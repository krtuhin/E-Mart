package com.emart.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name = "e_product_cart")
public class Cart {

    @Id
    @Column(name = "cart_id")
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    private int id;

    @Column(name = "product_Id", nullable = false)
    private int pId;

    @Column(name = "product_user_id", nullable = false, unique = true)
    private int productUserId;

    @OneToOne
    private User user;

    public Cart() {
    }

    public Cart(int pId, int productUserId, User user) {
        this.pId = pId;
        this.productUserId = productUserId;
        this.user = user;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getpId() {
        return pId;
    }

    public void setpId(int pId) {
        this.pId = pId;
    }

    public int getProductUserId() {
        return productUserId;
    }

    public void setProductUserId(int productUserId) {
        this.productUserId = productUserId;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @Override
    public String toString() {
        return "Cart{" + "id=" + id + ", pId=" + pId + ", productUserId=" + productUserId + ", user=" + user + '}';
    }

}
