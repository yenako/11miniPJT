package com.model2.mvc.web.product;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.DiskFileUpload;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUpload;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Comment;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;

@Controller
@RequestMapping("/product/*")
public class ProductController {

	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	///Constructor
	public ProductController(){
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	
	//@RequestMapping("/addProductView.do")
	@RequestMapping( value="addProduct", method=RequestMethod.GET)
	public ModelAndView addProduct() throws Exception{
		System.out.println("/product/addProduct : GET");
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("redirect:/product/addProductView.jsp"); //forward: default
		return modelAndView;
	}
	
	//@RequestMapping("/addProduct.do")
	@RequestMapping (value ="addProduct", method=RequestMethod.POST)
	public ModelAndView addProduct( 
									HttpServletRequest request,
									@RequestParam("file") MultipartFile file,
									@ModelAttribute("product") Product product
								  ) throws Exception {
	ModelAndView modelAndView = new ModelAndView();

	 try {

		 String uploadDir = "C:\\Users\\koh\\git\\11miniPJT\\11.Model2MVCShop(CSS,etc)YN\\WebContent\\images\\uploadFiles\\";
		 //String realPath = request.getServletContext().getRealPath(uploadDir);
		
		 File transferFile = new File(uploadDir  + file.getOriginalFilename()); 
		 file.transferTo(transferFile);
		 System.out.println("file transferred.... ");
		 product.setFileName(file.getOriginalFilename());
		 product.setManuDate(product.getManuDate().replaceAll("-",""));
		 /////////////////////////////////////////////////////////////////
		 System.out.println("the product that I`m trying to add is :: "+product);
		 productService.addProduct(product);
		 /////////////////////////////////////////////////////////////////
		 
		 
		 } catch (Exception e) {
			 e.printStackTrace();
		 	}

	 modelAndView.addObject("product", product);
	modelAndView.setViewName("/product/checkProduct.jsp");

		return modelAndView;
	}
	
	@RequestMapping(value="getProduct", method=RequestMethod.GET)
	public ModelAndView getProduct(@RequestParam("prodNo") int prodNo,
																		@RequestParam("menu") String menu,
																		HttpServletRequest request,
																		HttpServletResponse response,
																		Model model) throws Exception{
		System.out.println("/product/getProduct : GET");
		
		String newCookie = null;
		
		Cookie[] cookies = request.getCookies();
		if (cookies!=null && cookies.length > 0) {
				for (int i = 0; i < cookies.length; i++) {
					Cookie cookie = cookies[i];
					if (cookie.getName().equals("history")) {
						newCookie = cookie.getValue()+","+prodNo;
						System.out.println("newCookie의 값은 "+newCookie);
						cookie.setValue(newCookie);
						cookie.setPath("/");
					    response.addCookie(cookie);
					}
					else{
						cookie = new Cookie("history", prodNo+"");
						cookie.setPath("/");
					    response.addCookie(cookie);
					}
				}
		}//end of setting Cookie
		
		List<Comment> commentList = productService.getCommentList(prodNo);
		///////////////////////////////////////////////////////
		
		Product product = productService.getProduct( prodNo );
		
		ModelAndView modelAndView = new ModelAndView();
		if(menu.equals("manage")){
			model.addAttribute("prodNo", prodNo);
			modelAndView.addObject("commentList", commentList);
			modelAndView.setViewName("/product/updateProduct");
		}else{
			model.addAttribute("product", product);
			modelAndView.addObject("commentList", commentList);
			modelAndView.setViewName("/product/readProduct.jsp");
		}
	
		return modelAndView;
	}
	
	@RequestMapping(value="updateProduct", method=RequestMethod.GET)
	public ModelAndView updateProduct(@RequestParam("prodNo") int prodNo,
																Model model) throws Exception{
		System.out.println("/product/updateProduct : GET");
		
		model.addAttribute("product", productService.getProduct(prodNo));

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/product/updateProduct.jsp");
		return modelAndView;
	}
	
	@RequestMapping(value="updateProduct", method=RequestMethod.POST)
	public ModelAndView updateProduct(
																@RequestParam("file") MultipartFile file,
																@ModelAttribute("product") Product product) throws Exception{
		System.out.println("/product/updateProduct : POST");
		
		 String uploadDir = "C:\\Users\\koh\\git\\11miniPJT\\11.Model2MVCShop(CSS,etc)YN\\WebContent\\images\\uploadFiles\\";
		 //String realPath = request.getServletContext().getRealPath(uploadDir);
		
		 File transferFile = new File(uploadDir  + file.getOriginalFilename()); 
		 file.transferTo(transferFile);
		 System.out.println("file transferred.... ");
		 
/*			if(product.getFileName().length()<1){
				product.setFileName(null);
				System.out.println("product.getFileName().length()<1 이다.");
			}else{
				product.setFileName(file.getOriginalFilename());
			}*/
		 product.setFileName(file.getOriginalFilename());	
		product.setManuDate(product.getManuDate().replaceAll("-",""));
		productService.updateProduct(product);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject( "product", productService.getProduct(product.getProdNo()) );
		modelAndView.addObject("prodNo", product.getProdNo());
		modelAndView.setViewName("/product/getProduct.jsp");
		return modelAndView;

	}
	
	@RequestMapping(value="listProduct")
	public ModelAndView listProduct(@ModelAttribute("search") Search search,
															@RequestParam("menu") String menu,
															Model model) throws Exception{
		System.out.println("/product/listProduct : GET");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		Map<String , Object> map=productService.getProductList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		model.addAttribute("menu", menu);
		
		ModelAndView modelAndView = new ModelAndView();
	
		modelAndView.setViewName("/product/listProduct.jsp");
		return modelAndView;
	}
	
}
