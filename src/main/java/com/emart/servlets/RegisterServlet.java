package com.emart.servlets;

import com.emart.dataobject.UserDao;
import com.emart.entities.User;
import com.emart.helper.FactoryProvider;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

//multipart to get file input from html form
@MultipartConfig
public class RegisterServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            //own exception handling
            try {

                //chacking terms and condition
                String check = request.getParameter("check");

                if (check == null) {

                    //error message for terms and condition
                    HttpSession s = request.getSession();
                    s.setAttribute("msg", "Please accept terms & conditions and try again!!");
                    s.setAttribute("color", "warning");
                    response.sendRedirect("register.jsp");
                } else {

                    //accessing all the data from register form
                    String name = request.getParameter("name");
                    String email = request.getParameter("email");
                    String password = request.getParameter("password");
                    String phone = request.getParameter("phone");

                    //file input from html form
                    Part profile = request.getPart("profile");

                    String picture = new String();

                    //condition for checking input is null or not
                    if (profile.getSize() == 0) {

                        picture = "default.png";

                    } else {

                        //getting input file name
                        picture = profile.getSubmittedFileName();
                    }

                    //calling user object
                    User user = new User(name, email, password, phone, picture, "normal");

                    //save data into database using User dao class
                    int id = new UserDao().registerUserWithEmailAndPassword(user);

                    //image saving process
                    //access image path to save image into server
                    String path = request.getRealPath("img") + File.separator + "profiles" + File.separator + picture;

                    FileOutputStream fos = new FileOutputStream(path);

                    InputStream is = profile.getInputStream();

                    byte data[] = new byte[is.available()];

                    is.read(data);
                    fos.write(data);

                    fos.flush();
                    fos.close();
                    is.close();
                    //end image saving process

                    //registration successfull message
                    HttpSession httpSession = request.getSession();
                    httpSession.setAttribute("msg", "Registered Successfully..!!");
                    httpSession.setAttribute("color", "success");
                    response.sendRedirect("register.jsp");
                    return;
                }
            } catch (Exception e) {
                e.printStackTrace();

                //user exist message
                if (e.toString().equalsIgnoreCase("javax.persistence.PersistenceException: org.hibernate.exception.ConstraintViolationException: could not execute statement")) {
                    HttpSession s = request.getSession();
                    s.setAttribute("msg", "Email already exist, try with another..!");
                    s.setAttribute("color", "danger");
                    response.sendRedirect("register.jsp");

                } else {

                    //all other exception message
                    HttpSession s = request.getSession();
                    s.setAttribute("msg", "Problem occured try again!!");
                    s.setAttribute("color", "danger");
                    response.sendRedirect("register.jsp");
                }
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
