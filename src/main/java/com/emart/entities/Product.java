package com.emart.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "e_prodect")
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

    @Override
    public String toString() {
        return "Product{" + "id=" + id + ", name=" + name + ", desc=" + desc + ", price=" + price + ", photo=" + photo + ", discount=" + discount + ", quantity=" + quantity + '}';
    }

}
