package com.ders.bm470.controller;
import com.ders.bm470.model.*;
import com.ders.bm470.service.QuestionService;
import com.ders.bm470.service.TestService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;
import com.ders.bm470.model.Question;
import com.ders.bm470.service.TestResultService;
import com.ders.bm470.service.UserService;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.access.prepost.PreAuthorize;

import java.security.Principal;


import java.util.*;

@Controller
@RequestMapping("/tests")
public class TestController {

    private final TestService testService;
    private final UserService userService;
    private final TestResultService testResultService;


    @Autowired
    public TestController(TestService testService, UserService userService, TestResultService testResultService) {
        this.testService = testService;
        this.userService = userService;
        this.testResultService = testResultService;
    }
    // Test oluşturma formu göstermek için
    @PreAuthorize("hasRole('ADMIN')")
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
    @PreAuthorize("hasRole('ADMIN')")
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
    @PreAuthorize("hasRole('ADMIN')")
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
    @PreAuthorize("hasRole('ADMIN')")
    @GetMapping("/delete/{testId}")
    public String deleteTest(@PathVariable("testId") Long testId) {
        testService.deleteTest(testId);
        return "redirect:/home";
    }

    @GetMapping("/solve/{id}")
    public String solveTest(@PathVariable("id") Long testId,
                            @RequestParam(name = "q", defaultValue = "0") int questionIndex,
                            @SessionAttribute(name = "answers", required = false) List<String> answers,
                            Model model,
                            HttpSession session) {

        Test test = testService.getTestWithAllDetails(testId);
        List<Question> questions = test.getQuestions();

        if (answers == null) {
            answers = new ArrayList<>(Collections.nCopies(questions.size(), null));
            session.setAttribute("answers", answers);
        }

        if (questionIndex >= questions.size()) {
            return "redirect:/tests/solve/" + testId + "/summary";
        }

        Question currentQuestion = questions.get(questionIndex);

        model.addAttribute("testId", testId);
        model.addAttribute("questionIndex", questionIndex);
        model.addAttribute("question", currentQuestion);
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
                              HttpSession session,
                              Model model,
                              Principal principal) {

        Test test = testService.getTestWithAllDetails(testId);
        List<Question> questions = test.getQuestions();

        int correct = 0;
        int incorrect = 0;

        for (int i = 0; i < questions.size(); i++) {
            Question question = questions.get(i);
            String userAnswer = answers.get(i);

            Choice correctChoice = question.getChoices().stream()
                    .filter(Choice::isCorrect)
                    .findFirst()
                    .orElse(null);

            if (correctChoice != null && correctChoice.getText().equals(userAnswer)) {
                correct++;
            } else {
                incorrect++;
            }
        }

        // Kullanıcı bilgisi
        String username = principal.getName();
        User user = userService.findByUsername(username);

        // Sonucu kaydet
        TestResult result = TestResult.builder()
                .correctCount(correct)
                .incorrectCount(incorrect)
                .user(user)
                .test(test)
                .build();

        testResultService.saveResult(result);

        // Model verileri
        model.addAttribute("correct", correct);
        model.addAttribute("incorrect", incorrect);
        model.addAttribute("answers", answers);
        model.addAttribute("testId", testId);
        session.removeAttribute("answers");
        return "summary";
    }


}
