
## DELETE /api/v1/figures/:id 

### Назначение

Метод предназначен для удаления фигуры с листа.

### Логика работы:
1. Происходит получение входящих данных и валидация их. Если валидация не пройдена, то возвращается соответствующая ошибка;
2. Происходит проверка на существование фигуры в таблице figures по id. Если фигура не найдена, то возвращается соответствующая ошибка;
3. Удаляется запись в таблице figures по id;
4. Каскадным методом удаляются записи в таблицах points и edges по figure_id;
5. Возвращается ответ.