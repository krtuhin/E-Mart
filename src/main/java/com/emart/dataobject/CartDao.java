package com.emart.dataobject;

import com.emart.entities.Cart;
import com.emart.entities.Product;
import com.emart.helper.FactoryProvider;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

public class CartDao {

    //access session factory from factory provider class
    private SessionFactory factory = FactoryProvider.getFactory();

    //method for save product to user's cart
    public int saveItemToCart(Cart cart) {

        Session session = FactoryProvider.getFactory().openSession();
        Transaction tx = session.beginTransaction();

        int cId = (int) session.save(cart);

        tx.commit();
        session.close();

        return cId;
    }

    //method for getting all cart items for any user
    public List<Product> getAllProductFromCartByUserId(int userId) {

        //empty list of product
        List<Product> items = new ArrayList<>();

        Session session = FactoryProvider.getFactory().openSession();

        //query to get all cart items using user id
        Query query = session.createQuery("from Cart where user.id=:x").setParameter("x", userId);
        List<Cart> carts = query.getResultList();

        session.close();

        //condition for getting product in to product list from cart
        for (Cart c : carts) {
            int pId = c.getpId();

            items.add(new ProductDao().getProductById(pId));
        }

        return items;
    }

    //method for deleting product from user's cart
    public void deleteItemById(int pId) {

        //session
        Session session = FactoryProvider.getFactory().openSession();
        Transaction tx = session.beginTransaction();

        //delete query
        String query = "delete from Cart where pId=:x";

        Query q = session.createQuery(query);

        //set dynamic value
        q.setParameter("x", pId);

        q.executeUpdate();

        tx.commit();
        session.close();
    }
}
