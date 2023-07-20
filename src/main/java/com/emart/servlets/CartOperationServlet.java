package com.emart.servlets;

import com.emart.dataobject.CartDao;
import com.emart.entities.Cart;
import com.emart.entities.User;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class CartOperationServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            //custom try catch
            try {

                //get http session
                HttpSession s = request.getSession();

                //fetch current user data
                User user = (User) s.getAttribute("currentUser");

                if (user == null) {

                    //if not logged in then send to login page
                    HttpSession httpSession = request.getSession();
                    httpSession.setAttribute("msg", "Please login to add product in your cart..!");
                    httpSession.setAttribute("color", "danger");
                    response.sendRedirect("login.jsp");

                } else {
                    //check operation type
                    String operation = request.getParameter("operation");

                    //if type is add then add product to wishlist
                    if (operation.equalsIgnoreCase("add") || operation.equalsIgnoreCase("p-add")) {

                        String pId = request.getParameter("product");

                        //failure message if order id not accessed
                        if (pId.isBlank()) {

                            HttpSession httpSession = request.getSession();
                            httpSession.setAttribute("msg", "Problem occured in our side, try again..!");
                            httpSession.setAttribute("color", "danger");

                            if (operation.equalsIgnoreCase("p-add")) {

                                response.sendRedirect("product_details.jsp?p_id=" + pId);

                            } else {

                                response.sendRedirect("home.jsp");
                            }
                        } else {

                            //store data into cart object
                            String productUserId = String.valueOf(pId) + String.valueOf(user.getId());
                            Cart cart = new Cart(Integer.parseInt(pId), Integer.parseInt(productUserId), user);

                            //save data into database by cart dao class
                            int cId = new CartDao().saveItemToCart(cart);

                            //item add success message
                            HttpSession httpSession = request.getSession();
                            httpSession.setAttribute("msg", "Item added into cart..!");
                            httpSession.setAttribute("color", "success");

                            if (operation.equalsIgnoreCase("p-add")) {

                                response.sendRedirect("product_details.jsp?p_id=" + pId);

                            } else {

                                response.sendRedirect("home.jsp");
                            }
                        }

                        //if operation type is remove then delete item from cart
                    } else if (operation.equalsIgnoreCase("remove")) {

                        int pId = Integer.parseInt(request.getParameter("product-id"));

                        //delete item from cart by cart dao class
                        new CartDao().deleteItemById(pId);

                        //delete success message
                        HttpSession httpSession = request.getSession();
                        httpSession.setAttribute("msg", "Item removed successfully..!");
                        httpSession.setAttribute("color", "success");
                        response.sendRedirect("wishlist.jsp");
                    }
                }
            } catch (Exception e) {

                //if any exception occured then send this message
                HttpSession httpSession = request.getSession();
                httpSession.setAttribute("msg", "Something went wrong..!");
                httpSession.setAttribute("color", "danger");
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
