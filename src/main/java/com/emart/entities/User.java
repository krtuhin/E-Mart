package com.emart.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "e_user")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    private int id;

    @Column(name = "user_name")
    private String name;

    @Column(name = "user_email")
    private String email;

    @Column(name = "user_password")
    private String password;

    @Column(length = 11, name = "user_phone")
    private int phone;

    @Column(name = "user_pic")
    private String picture;

    @Column(name = "user_address", length = 1500)
    private String address;

    public User(int id, String userName, String usrEmail, String userPassword, int userPhone, String userPic, String userAddress) {
        this.id = id;
        this.name = userName;
        this.email = usrEmail;
        this.password = userPassword;
        this.phone = userPhone;
        this.picture = userPic;
        this.address = userAddress;
    }

    public User() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUserName() {
        return name;
    }

    public void setUserName(String userName) {
        this.name = userName;
    }

    public String getUsrEmail() {
        return email;
    }

    public void setUsrEmail(String usrEmail) {
        this.email = usrEmail;
    }

    public String getUserPassword() {
        return password;
    }

    public void setUserPassword(String userPassword) {
        this.password = userPassword;
    }

    public int getUserPhone() {
        return phone;
    }

    public void setUserPhone(int userPhone) {
        this.phone = userPhone;
    }

    public String getUserPic() {
        return picture;
    }

    public void setUserPic(String userPic) {
        this.picture = userPic;
    }

    public String getUserAddress() {
        return address;
    }

    public void setUserAddress(String userAddress) {
        this.address = userAddress;
    }

    @Override
    public String toString() {
        return "User{" + "id=" + id + ", name=" + name + ", email=" + email + ", password=" + password + ", phone=" + phone + ", picture=" + picture + ", address=" + address + '}';
    }

}
