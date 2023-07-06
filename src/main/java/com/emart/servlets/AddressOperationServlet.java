package com.emart.servlets;

import com.emart.dataobject.AddressDao;
import com.emart.entities.Address;
import com.emart.entities.User;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AddressOperationServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            //custome try catch
            try {

                //fetch data from form
                String operation = request.getParameter("operation");

                //checking the operation is delete operation or not
                if (operation.trim().equalsIgnoreCase("delete")) {

                    int addressId = Integer.parseInt(request.getParameter("address-id"));

                    //delete a particular delivery address from a particular user 
                    new AddressDao().deleteAddressById(addressId);

                    //delete success message
                    HttpSession session = request.getSession();
                    session.setAttribute("msg", "Address deleted successfully..!");
                    session.setAttribute("color", "success");
                    response.sendRedirect("order.jsp");

                    //checking the operation is save operation or not
                } else if (operation.trim().equalsIgnoreCase("save")) {

                    //fetch data from html form
                    String name = request.getParameter("name");
                    String email = request.getParameter("email");
                    String phone = request.getParameter("mobile");
                    String city = request.getParameter("city");
                    String district = request.getParameter("dist");
                    String state = request.getParameter("state");
                    String pin = request.getParameter("pin");
                    String house = request.getParameter("house");
                    String area = request.getParameter("area");

                    //access session for get current logged in user id
                    HttpSession session = request.getSession();
                    User user = (User) session.getAttribute("currentUser");

                    //create object for address
                    Address address = new Address(name, email, phone, city, district, state, pin, house, area, user.getId());

                    //save address data into database using address dao class
                    int id = new AddressDao().saveAddress(address);

                    //successfull message for add address into database
                    session.setAttribute("msg", "Address added successfully..!");
                    session.setAttribute("color", "success");
                    response.sendRedirect("order.jsp");
                }
            } catch (Exception e) {

                //failure message for add address into database when any exception is occured
                HttpSession session = request.getSession();
                session.setAttribute("msg", "Something went wrong, try again..!");
                session.setAttribute("color", "danger");
                response.sendRedirect("order.jsp");
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
