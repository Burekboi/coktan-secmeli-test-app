package com.ders.bm470.controller;

import com.ders.bm470.model.Test;
import com.ders.bm470.service.TestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

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
        model.addAttribute("test", new Test());
        return "create_test";
    }

    // Form submit edildiğinde testi kaydetmek için
    @PostMapping("/create")
    public String createTest(@ModelAttribute("test") Test test) {
        Test savedTest = testService.saveTest(test);
        return "redirect:/home";
    }

    // Test detay sayfası
    @GetMapping("/detail/{testId}")
    public String showTestDetail(@PathVariable("testId") Long testId, Model model) {
        Test test = testService.getTestWithAllDetails(testId);
        if (test == null) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Test bulunamadı: " + testId);
        }
        model.addAttribute("test", test);
        return "test_detail";
    }

    // Test düzenleme formu göstermek için
    @GetMapping("/edit/{testId}")
    public String showEditTestForm(@PathVariable("testId") Long testId, Model model) {
        Test test = testService.getTestById(testId);
        if (test == null) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Test bulunamadı: " + testId);
        }
        model.addAttribute("test", test);
        return "edit_test";
    }

    // Düzenleme formu submit edildiğinde güncelleme işlemi
    @PostMapping("/edit/{testId}")
    public String updateTest(@PathVariable("testId") Long testId,
                             @ModelAttribute("test") Test test) {
        // 1) Varolan Test'i DB'den tamamen yüklü şekilde al (questions ile birlikte)
        Test existing = testService.getTestWithAllDetails(testId);
        if (existing == null) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Test bulunamadı: " + testId);
        }

        // 2) Sadece güncellenen alanları kopyala (name vb.)
        existing.setName(test.getName());
        // eğer başka alanlar varsa onlar da burada set edilebilir

        // 3) Kaydet
        testService.saveTest(existing);

        return "redirect:/home";
    }


    // Test silme işlemi
    @GetMapping("/delete/{testId}")
    public String deleteTest(@PathVariable("testId") Long testId) {
        testService.deleteTest(testId);
        return "redirect:/home";
    }

}
