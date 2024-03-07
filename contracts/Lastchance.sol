// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

// Uncomment this line to use console.log
// import "hardhat/console.sol";



contract Lastchance{

        string public storeName = " Lastchance decentralized " ;

        uint public count = 0 ;

        struct Product {

         uint id ;
         string name ;
         string description ;
         string image ;
         bool sold ;
         address payable owner ;
         uint price ;
         string category ;
        }

event CreateProduct (

         uint id ,
         string name ,
         string description ,
         string image ,
         bool sold ,
         address payable owner ,
         uint price ,
         string category
);


event BuyProduct (

         string name ,
         bool sold ,
         address payable owner ,
         uint price
);

mapping (uint => Product) public storeProducts ;

 function createProduct (string memory name , string memory description , string memory image , uint price , string memory category ) public {
    // confirm ther is valid data
   require(price >0, "The Price Should Be More Than 0 " ) ;
   require(bytes(name).length >4, "The Name Should Be More Than 4 " ) ;
   require(bytes(description).length >10, "The Description Should Be More Than 10 " ) ;
   require(bytes(image).length >10, "The Image Should Be More Than 0 " ) ;
   require(bytes(category).length >1, "The Category Should Be More Than 1 " ) ;

    // add the product to list
           count ++ ;
           storeProducts[count]=Product(count,name,description,image,false,payable (msg.sender),price,category);
           emit CreateProduct(count, name, description, image, false, payable (msg.sender), price, category);
 }

  function buyProduct(uint _id) public payable{
    Product memory singleProduct = storeProducts[_id] ;
    address payable seller =singleProduct.owner ;

    require(seller != msg.sender , "Can not buy your product ");

    require(msg.value >= singleProduct.price,"The Price Should Be equal the product Price");
    require(!singleProduct.sold,"This prodect solded");


    payable (seller).transfer(msg.value) ;
    singleProduct.owner = payable (msg.sender) ;
    singleProduct.sold = true ;
    storeProducts[_id] = singleProduct ;

          emit BuyProduct(singleProduct.name , true , payable(msg.sender),singleProduct.price);

  }

 }


