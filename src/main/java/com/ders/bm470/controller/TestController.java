package com.ders.bm470.controller;

import com.ders.bm470.model.Test;
import com.ders.bm470.service.TestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/tests")
public class TestController {

    private final TestService testService;

    @Autowired
    public TestController(TestService testService) {
        this.testService = testService;
    }

    // Test oluşturma formu göstermek için
    @GetMapping("/create")
    public String showCreateTestForm(Model model) {
        model.addAttribute("test", new Test()); // Boş test nesnesi
        return "create_test"; // create_test.jsp olacak
    }

    // Form submit edildiğinde testi kaydetmek için
    @PostMapping("/create")
    public String createTest(@ModelAttribute("test") Test test) {
        System.out.println("Formdan gelen test: " + test);
        Test savedTest = testService.saveTest(test);
        System.out.println("Kaydedilen test: " + savedTest);
        return "redirect:/home";
    }


}
