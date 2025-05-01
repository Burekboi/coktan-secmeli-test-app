package com.ders.bm470.service;

import com.ders.bm470.model.Choice;

import java.util.List;

public interface ChoiceService {
    Choice saveChoice(Choice choice);
    Choice getChoiceById(Long id);
    void deleteChoiceById(Long id);
    List<Choice> getAllChoices();  // isterseniz listeleme için
}
