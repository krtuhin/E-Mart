package com.emart.entities;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "e_order")
public class Order {

    @Id
    @Column(name = "order_id")
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    private int id;

    @Column(name = "user_id", nullable = false)
    private String userId;

    @Column(name = "product_id", nullable = false)
    private String productId;

    @Column(name = "address_id", nullable = false)
    private String addressId;

    @Column(name = "payment_mode", nullable = false)
    private String paymentMode;

    @Column(name = "order_date", nullable = false)
    private Date orderDate;

    public Order() {
    }

    public Order(int id, String userId, String productId, String addressId, String paymentMode, Date orderDate) {
        this.id = id;
        this.userId = userId;
        this.productId = productId;
        this.addressId = addressId;
        this.paymentMode = paymentMode;
        this.orderDate = orderDate;
    }

    public Order(String userId, String productId, String addressId, String paymentMode, Date orderDate) {
        this.userId = userId;
        this.productId = productId;
        this.addressId = addressId;
        this.paymentMode = paymentMode;
        this.orderDate = orderDate;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public String getAddressId() {
        return addressId;
    }

    public void setAddressId(String addressId) {
        this.addressId = addressId;
    }

    public String getPaymentMode() {
        return paymentMode;
    }

    public void setPaymentMode(String paymentMode) {
        this.paymentMode = paymentMode;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    @Override
    public String toString() {
        return "Order{" + "id=" + id + ", userId=" + userId + ", productId=" + productId + ", addressId=" + addressId + ", paymentMode=" + paymentMode + ", orderDate=" + orderDate + '}';
    }

}
