package com.emart.dataobject;

import com.emart.entities.User;
import com.emart.helper.FactoryProvider;
import java.util.List;
import javax.persistence.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

public class UserDao {

    //method for register user
    public int registerUserWithEmailAndPassword(User user) {

        //getting hibernate session
        Session session = FactoryProvider.getFactory().openSession();

        //create transaction
        Transaction transaction = session.beginTransaction();

        //saving user data into database
        int userId = (int) session.save(user);

        //commit transaction and close session
        transaction.commit();
        session.close();

        return userId;
    }

    //method for login user
    public List<User> loginUserWithEmailAndPassword(String email, String password) {

        //hibernate session for save data into database
        Session s = FactoryProvider.getFactory().openSession();

        //HQL
        String query = "from User where email=:x and password=:y";

        Query q = s.createQuery(query);

        //dynamic value set
        q.setParameter("x", email);
        q.setParameter("y", password);

        //get result from database
        List<User> userList = q.getResultList();

        s.close();

        return userList;
    }

    //method for get all user from database
    public List<User> getAllUser(SessionFactory factory) {

        Session s = factory.openSession();
        List<User> users = s.createQuery("from User").getResultList();
        s.close();

        return users;
    }

    //method for update user details
    public User updateUser(int userId, User u) {

        //hibernate session
        Session s = FactoryProvider.getFactory().openSession();
        Transaction tx = s.beginTransaction();

        //update data in database using hibernate
        //fetch current user from database
        User user = s.get(User.class, userId);

        //set attributes (update attributes)
        //it will automatically update user details in database
        user.setUserName(u.getUserName());
        user.setUsrEmail(u.getUsrEmail());
        user.setUserPassword(u.getUserPassword());
        user.setUserPhone(u.getUserPhone());
        user.setUserPic(u.getUserPic());

        tx.commit();
        s.close();

        return user;
    }
}
