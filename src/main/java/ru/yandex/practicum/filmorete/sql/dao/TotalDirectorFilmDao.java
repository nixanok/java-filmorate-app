package ru.yandex.practicum.filmorete.sql.dao;

import ru.yandex.practicum.filmorete.model.TotalDirectorFilm;

import java.util.List;
import java.util.Optional;

public interface TotalDirectorFilmDao {

    List<TotalDirectorFilm> findAll();

    Optional<TotalDirectorFilm> findById(Long rowId);

    void insert(TotalDirectorFilm totalDirectorFilm);

    void update(TotalDirectorFilm totalDirectorFilm);

    void deleteById(Long rowId);
}
