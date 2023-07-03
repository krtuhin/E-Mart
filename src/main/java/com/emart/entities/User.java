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

    @Column(name = "user_name", nullable = false)
    private String name;

    @Column(name = "user_email", nullable = false, unique = true)
    private String email;

    @Column(name = "user_password", nullable = false)
    private String password;

    @Column(length = 11, name = "user_phone", nullable = false)
    private String phone;

    @Column(name = "user_pic", nullable = false)
    private String picture;

    @Column(name = "user_type", length = 10, nullable = false)
    private String userType;

    public User() {
    }

    public User(String name, String email, String password, String phone, String picture, String userType) {
        this.name = name;
        this.email = email;
        this.password = password;
        this.phone = phone;
        this.picture = picture;
        this.userType = userType;
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

    public String getUserPhone() {
        return phone;
    }

    public void setUserPhone(String userPhone) {
        this.phone = userPhone;
    }

    public String getUserPic() {
        return picture;
    }

    public void setUserPic(String userPic) {
        this.picture = userPic;
    }

    public String getUserType() {
        return userType;
    }

    public void setUserType(String userType) {
        this.userType = userType;
    }

    @Override
    public String toString() {
        return "User{" + "id=" + id + ", name=" + name + ", email=" + email + ", password=" + password + ", phone=" + phone + ", picture=" + picture + ", userType=" + userType + '}';
    }

}
