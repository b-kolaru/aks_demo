package com.bkolaru.hplus.aksdemo.controller;


import com.bkolaru.hplus.aksdemo.services.ProductService;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping
public class ProductController {

    ProductService productService;

    @GetMapping("/search/{Search}")
    public String getProduct(@PathVariable("Search") String productName, Model model){

        model.addAttribute("search", productService.getProductByName(productName));

                return "search";

    }
}
