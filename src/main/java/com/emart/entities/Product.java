package com.emart.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "e_product")
public class Product {

    @Id
    @Column(name = "p_id")
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    private int id;

    @Column(name = "p_name")
    private String name;

    @Column(name = "p_description", length = 3000)
    private String desc;

    @Column(name = "p_price")
    private int price;

    @Column(name = "p_photo")
    private String photo;

    @Column(name = "p_discount")
    private int discount;

    @Column(name = "p_quantity")
    private int quantity;

    @ManyToOne
    private Category category;

    public Product() {
    }

    public Product(int id, String name, String desc, int price, String photo, int discount, int quantity, Category category) {
        this.id = id;
        this.name = name;
        this.desc = desc;
        this.price = price;
        this.photo = photo;
        this.discount = discount;
        this.quantity = quantity;
        this.category = category;
    }

    public Product(String name, String desc, int price, String photo, int discount, int quantity, Category category) {
        this.name = name;
        this.desc = desc;
        this.price = price;
        this.photo = photo;
        this.discount = discount;
        this.quantity = quantity;
        this.category = category;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public int getDiscount() {
        return discount;
    }

    public void setDiscount(int discount) {
        this.discount = discount;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    @Override
    public String toString() {
        return "Product{" + "id=" + id + ", name=" + name + ", desc=" + desc + ", price=" + price + ", photo=" + photo + ", discount=" + discount + ", quantity=" + quantity + ", category=" + category + '}';
    }

    //method for get price after discount
    public int getDiscountPrice() {

        return this.price - ((this.price * this.discount) / 100);
    }

    //method for get optimized description
    public String getDescription() {

        if (this.desc.length() > 65) {

            return this.desc.substring(0, 65) + "...";

        } else {

            return this.desc;

        }
    }

    //method for get optimized title
    public String getTitle() {

        if (this.name.length() > 40) {

            return this.name.substring(0, 40) + "...";

        } else {

            return this.name;
        }
    }

}
