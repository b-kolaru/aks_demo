package com.bkolaru.hplus.aksdemo.data;


import com.bkolaru.hplus.aksdemo.model.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ProductRepo extends JpaRepository<Product, Integer> {



}
