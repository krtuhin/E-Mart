package com.emart.dataobject;

import com.emart.entities.Category;
import com.emart.helper.FactoryProvider;
import java.util.List;
import javax.persistence.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

public class CategoryDao {

    public int saveCategory(SessionFactory factory, Category category) {

        Session session = FactoryProvider.getFactory().openSession();
        Transaction tx = session.beginTransaction();

        int id = (int) session.save(category);

        tx.commit();
        session.close();

        return id;
    }

    public List<Category> getAllCategory(SessionFactory factory) {

        Session session = factory.openSession();
        Query query = session.createQuery("from Category");
        List<Category> categories = query.getResultList();

        session.close();

        return categories;
    }

    public Category getCategoryById(SessionFactory factory, int cId) {

        Session session = factory.openSession();

        Category category = session.get(Category.class, cId);

        session.close();

        return category;
    }
}
