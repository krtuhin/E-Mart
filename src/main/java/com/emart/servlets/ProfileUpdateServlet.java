package com.emart.servlets;

import com.emart.dataobject.UserDao;
import com.emart.entities.User;
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

//multipart for fetch file from html form
@MultipartConfig
public class ProfileUpdateServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            //custom try catch
            try {

                //get http session
                HttpSession s = request.getSession();

                //fetch data from html form
                String name = request.getParameter("name");
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                String mobile = request.getParameter("mobile");
                Part profile = request.getPart("profile");
                String image = profile.getSubmittedFileName();

                //if form data is empty then show error message
                if (name.isBlank() || email.isBlank() || password.isBlank() || mobile.isBlank()) {
                    s.setAttribute("msg", "Mandatory field cannot be empty..!");
                    s.setAttribute("color", "danger");
                    response.sendRedirect("home.jsp");
                    return;
                }

                //fetch current user
                User currentUser = (User) s.getAttribute("currentUser");

                //fetch old picture name from current user
                String oldPicture = currentUser.getUserPic();

                //create user object to store new values
                User user = new User();

                //save form value to user object
                user.setUserName(name);
                user.setUsrEmail(email);
                user.setUserPassword(password);
                user.setUserPhone(mobile);

                //if picture is not updated then it remain same
                //otherwise change to current picture
                if (image.isBlank()) {

                    user.setUserPic(oldPicture);

                } else {
                    user.setUserPic(image);

                    //path for save new image
                    String newPath = request.getRealPath("img") + File.separator + "profiles" + File.separator + image;

                    //create byte array as long as image size
                    InputStream is = profile.getInputStream();
                    byte data[] = new byte[is.available()];
                    FileOutputStream fos = new FileOutputStream(newPath);

                    //if image is not default image then delete old image 
                    if (!oldPicture.trim().equalsIgnoreCase("default.png")) {

                        //old image path
                        String oldPath = request.getRealPath("img") + File.separator + "profiles" + File.separator + oldPicture;

                        //delete image
                        File file = new File(oldPath);
                        file.delete();

                    } else {
                    }

                    //save new image
                    is.read(data);
                    fos.write(data);

                    is.close();
                    fos.flush();
                    fos.close();
                }

                //update new values into user database using user dao class
                User newUser = new UserDao().updateUser(currentUser.getId(), user);

                //set update user into session
                s.setAttribute("currentUser", newUser);

                //update success message
                s.setAttribute("msg", "Profile updated successfully..!");
                s.setAttribute("color", "success");
                response.sendRedirect("home.jsp");

            } catch (Exception e) {

                e.printStackTrace();

                //failure message for any exception
                HttpSession s = request.getSession();
                s.setAttribute("msg", "Something went wrong, please try again..!");
                s.setAttribute("color", "danger");
                response.sendRedirect("home.jsp");
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
