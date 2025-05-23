package com.ders.bm470.security;



import com.ders.bm470.model.User;
import com.ders.bm470.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class CustomUserDetailsService implements UserDetailsService {

    @Autowired
    private UserRepository userRepo;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = userRepo.findByUsername(username);


        if (user == null) {
            throw new UsernameNotFoundException("Kullanıcı bulunamadı: " + username);
        }
        return new CustomUserDetails(user);
    }
}
