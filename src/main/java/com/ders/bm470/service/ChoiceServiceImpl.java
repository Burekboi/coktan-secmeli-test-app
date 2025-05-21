package com.ders.bm470.service;

import com.ders.bm470.model.Choice;
import com.ders.bm470.model.Question;
import com.ders.bm470.repository.ChoiceRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ders.bm470.service.QuestionService;

import java.util.List;

@Service
public class ChoiceServiceImpl implements ChoiceService {

    private final ChoiceRepository choiceRepo;
    private  QuestionService questionService;

    @Autowired
    public ChoiceServiceImpl(ChoiceRepository choiceRepo, QuestionService questionService) {
        this.choiceRepo = choiceRepo;
        this.questionService = questionService;
    }

    @Override
    @Transactional
    public Choice saveChoice(Choice choice) {
        if (choice.isCorrect()) {
            Question question = choice.getQuestion();
            if (question == null || question.getId() == null) {
                throw new IllegalArgumentException("Şık bir soruya bağlı olmalıdır.");
            }

            // Mevcut question'ı veritabanından çek
            Question existingQuestion = questionService.getQuestionById(question.getId());

            // O soruya ait tüm şıkları gezip varsa doğru olanı pasifleştir
            existingQuestion.getChoices().forEach(c -> {
                if (c.isCorrect()) {
                    c.setCorrect(false); // önceki doğruyu sıfırla
                    choiceRepo.save(c);  // update et
                }
            });
        }

        return choiceRepo.save(choice); // yeni şıkkı kaydet
    }


    @Override
    public Choice getChoiceById(Long id) {
        return choiceRepo.findById(id).orElse(null);
    }

    @Override
    @Transactional
    public void deleteChoiceById(Long id) {
        choiceRepo.deleteById(id);
    }

    @Override
    public List<Choice> getAllChoices() {
        return choiceRepo.findAll();
    }
}
