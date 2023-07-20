package com.emart.dataobject;

import com.emart.entities.Order;
import com.emart.helper.FactoryProvider;
import java.util.List;
import javax.persistence.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

public class OrderDao {

    //getting session factory
    private SessionFactory factory = FactoryProvider.getFactory();

    //method for do new order by any user
    public int doOrder(Order order) {

        Session s = this.factory.openSession();
        Transaction tx = s.beginTransaction();

        int id = (int) s.save(order);

        tx.commit();
        s.close();

        return id;
    }

    //method for get all order for a particular user by user id
    public List<Order> getAllOrderDetailsByUserId(int userId) {

        Session s = this.factory.openSession();

        Query query = s.createQuery("from Order where userId =: x");

        List<Order> orders = query.setParameter("x", userId).getResultList();

        s.close();

        return orders;
    }

    //method for getting a particular order details
    public Order getOrderDetailsById(int ordId, String userId) {

        Order order = null;

        Session s = this.factory.openSession();

        Query query = s.createQuery("from Order where id =: x and userId =: y");

        query.setParameter("x", ordId);
        query.setParameter("y", userId);

        List<Order> orders = query.getResultList();

        for (Order o : orders) {

            order = o;
        }

        s.close();

        return order;
    }
}
