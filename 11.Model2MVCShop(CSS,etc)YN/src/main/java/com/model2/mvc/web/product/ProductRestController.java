package com.model2.mvc.web.product;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.codehaus.jackson.map.ObjectMapper;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;

@RestController
@RequestMapping("/product/*")
public class ProductRestController {
	
		///Field
		@Autowired
		@Qualifier("productServiceImpl")
		private ProductService productService;
		//setter Method 구현 않음

		public ProductRestController() {
			System.out.println(this.getClass());
		}
		
		@RequestMapping(value = "json/addProduct", method=RequestMethod.POST)
		public int  addProduct(@RequestParam("imageFile") MultipartFile file,
													@RequestParam("product") String productString,
													HttpServletRequest request) throws Exception{
			
			System.out.println("/product/json/addProduct : POST");
			System.out.println(" :: "+file.getOriginalFilename() +"::" +productString);
			
			Product product  = new Product();
			//Business Logic
			try{
				String uploadDir = "C:\\bitcamp\\mini-PJT\\";
				 //String realPath = request.getServletContext().getRealPath(uploadDir);

				 File transferFile = new File(uploadDir  + file.getOriginalFilename()); 
				 file.transferTo(transferFile);
				 
				 ObjectMapper objectMapper = new ObjectMapper();
				 product = objectMapper.readValue(productString, Product.class);
				 product.setFileName(file.getOriginalFilename());
				 
			}catch (Exception e) {
				 e.printStackTrace();
			}
			
			return productService.addProduct(product);
		}
		
		@RequestMapping(value = "json/getProdNames", method=RequestMethod.GET)
		public List<String> getProdNames() throws Exception{
			System.out.println("/product/json/getProdNames : GET");
			
			Search search  = new Search();
			if(search.getCurrentPage() ==0 ){
				search.setCurrentPage(1);
			}
			search.setPageSize(100);
			
			Map<String , Object> map=productService.getProductList(search);
			List<Product> list = (List)map.get("list");
			
			List<String> listProdName = new ArrayList<String>();
			
			for(int i=0; i<list.size(); i++){
				Product product = (Product)list.get(i);
				listProdName.add(product.getProdName());				
			}
			
			return listProdName;
		}
		
		@RequestMapping(value = "json/listProduct/{currentPage}", method=RequestMethod.GET)
		public List<Product> listProduct(@PathVariable("currentPage") int currentPage) 
																										throws Exception{
			System.out.println("/product/json/listProduct : GET");
			System.out.println("currentPage 받은 값은 : "+currentPage);
			
			Search search  = new Search();
			search.setCurrentPage(currentPage);
			search.setPageSize(10);
			
			Map<String , Object> map=productService.getProductList(search);
			List<Product> list = (List)map.get("list");

			return list;
		}
		
		@RequestMapping(value = "json/getProduct/{prodNo}/{menu}", method=RequestMethod.GET)
		public Product getProduct(@PathVariable("prodNo") int prodNo,
															@PathVariable("menu") String menu ) throws Exception{
			System.out.println("/product/json/getProduct : GET");
			//Business Logic
			//1. cookie 처리
			
//			if(menu.equals("manage")){
//				model.addAttribute("prodNo", prodNo);
//				modelAndView.setViewName("/product/updateProduct");
//			}else{
//				model.addAttribute("product", product);
//				modelAndView.setViewName("/product/readProduct.jsp");
//			}
			return productService.getProduct(prodNo);
		}
		
		
		@RequestMapping(value = "json/updateProduct/{prodNo}", method=RequestMethod.GET)
		public Product updateProduct(@PathVariable int prodNo) throws Exception{
			System.out.println("/product/json/updateProduct : GET");
			//Business Logic
			return productService.getProduct(prodNo);
		}
		
		@RequestMapping(value = "json/updateProduct", method=RequestMethod.POST)
		public int  updateProduct(@RequestBody Product product) throws Exception{
			
			System.out.println("/product/json/updateProduct : POST");
			//Business Logic
			return productService.updateProduct(product);
		}
		

}
