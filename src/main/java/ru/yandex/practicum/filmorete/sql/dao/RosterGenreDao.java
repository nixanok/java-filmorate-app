package ru.yandex.practicum.filmorete.sql.dao;

import ru.yandex.practicum.filmorete.model.Genre;
import java.util.List;
import java.util.Optional;

public interface RosterGenreDao {

    List<String> findAllName();

    List<Genre> findRows();

    Optional<Integer> findLastId();

    Optional<Genre> findRow(Integer rowId);

    Optional<Genre> findRow(String name);

    void insert(String name);

    void insert(Integer rowId, String name);

    void update(Integer searchRowId, String name);

    void delete();

    void delete(Integer rowId);

    void delete(String name);
}
