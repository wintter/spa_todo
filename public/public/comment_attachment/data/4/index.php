<?php
Class Product {

   private $name;
   private $weight;
   private $price;

   public function __construct($name, $weight, $price){
   	$this->name = $name;
   	$this->weight = $weight;
   	$this->price = $price;
   }

   public function __get($name){
   	return $this->name;
   }

   public function __set($name, $value){
   	return $this->name = $value;
   }
   
}

$nokia = new Product("nokia", "600", 1200);
var_dump($nokia);