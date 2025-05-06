package com.ders.bm470.controller;

import com.ders.bm470.model.Test;
import com.ders.bm470.service.TestService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.util.*;

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

    // Bu, test çözüm süreci boyunca kullanılacak sabit liste (ileride servisten gelecek)
    private final List<Map<String, Object>> exampleQuestions = List.of(
            Map.of("text", "Türkiye'nin başkenti neresidir?",
                    "options", List.of("İstanbul", "Ankara", "İzmir", "Bursa", "Antalya")),
            Map.of("text", "2 + 2 işleminin sonucu nedir?",
                    "options", List.of("2", "3", "4", "5", "6"))
    );

    @GetMapping("/solve/{id}")
    public String solveTest(@PathVariable("id") Long testId,
                            @RequestParam(name = "q", defaultValue = "0") int questionIndex,
                            @SessionAttribute(name = "answers", required = false) List<String> answers,
                            Model model,
                            HttpSession session) {
        if (answers == null) {
            answers = new ArrayList<>(Collections.nCopies(exampleQuestions.size(), null));
            session.setAttribute("answers", answers);
        }

        if (questionIndex >= exampleQuestions.size()) {
            return "redirect:/tests/solve/" + testId + "/summary";
        }

        model.addAttribute("testId", testId);
        model.addAttribute("questionIndex", questionIndex);
        model.addAttribute("question", exampleQuestions.get(questionIndex));
        model.addAttribute("answers", answers);
        return "solve";
    }

    @PostMapping("/solve/{id}/answer")
    public String saveAnswer(@PathVariable("id") Long testId,
                             @RequestParam("questionIndex") int questionIndex,
                             @RequestParam("answer") String answer,
                             HttpSession session) {

        List<String> answers = (List<String>) session.getAttribute("answers");
        if (answers != null && questionIndex < answers.size()) {
            answers.set(questionIndex, answer);
        }

        return "redirect:/tests/solve/" + testId + "?q=" + (questionIndex + 1);
    }

    @GetMapping("/solve/{id}/summary")
    public String showSummary(@PathVariable("id") Long testId,
                              @SessionAttribute(name = "answers") List<String> answers,
                              Model model) {
        model.addAttribute("answers", answers);
        model.addAttribute("testId", testId);
        return "summary";
    }

}
