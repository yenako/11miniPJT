package com.model2.mvc.web.puchase;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;

@RestController
@RequestMapping("/purchase/*")
public class PurchaseRestController {
	
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;

	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	public PurchaseRestController(){
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	@RequestMapping(value="json/addPurchase/{prodNo}", method=RequestMethod.GET)
	public Product addPurchase(@PathVariable int prodNo) throws Exception{
		
		System.out.println("/purchase/json/addPurchase : GET");

		return productService.getProduct(prodNo);
	}
	
	@RequestMapping(value="json/addPurchase", method=RequestMethod.POST)
	public int addPurchase(@RequestBody Purchase purchase) throws Exception{
		
		System.out.println("/purchase/json/addPurchase : GET");

		return purchaseService.addPurchase(purchase);
	}
	
	@RequestMapping(value = "json/getPurchase/{tranNo}", method=RequestMethod.GET)
	public Purchase getPurchase(@PathVariable("tranNo") int tranNo) throws Exception{
		
		System.out.println("/product/json/getProduct : GET");

		return purchaseService.getPurchase(tranNo);
	}
	
	@RequestMapping( value="json/listPurchase" )
	public Map<String, Object> listPurchase(@RequestBody Search search,
															HttpSession session, Model model) throws Exception{
		System.out.println("/purchase/listPurchase");
		System.out.println("\n [ From Client Data ]");
		System.out.println(search);
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		System.out.println("[ To Clinent Data ]"); 
		//User user = (User) session.getAttribute("user");
		//search.setSearchKeyword(user.getUserId());
		Map<String , Object> map=purchaseService.getPurchaseList(search, search.getSearchKeyword());
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		Map<String , Object> jsonMap = new HashMap<String, Object>();
		//jsonMap.put("buyerId", user.getUserId());
		jsonMap.put("buyerId",  search.getSearchKeyword());
		jsonMap.put("list", map.get("list"));
		jsonMap.put("resultPage", resultPage);
		jsonMap.put("search", search);

		return map;
	}	
	
//	@RequestMapping(value = "json/getPurchase/{prodNo}", method=RequestMethod.GET)
//	public Purchase getPurchase2(@PathVariable("prodNo") int prodNo) throws Exception{
//		
//		System.out.println("/product/json/getProduct2 : GET");
//
//		return purchaseService.getPurchase2(prodNo);
//	}
}
