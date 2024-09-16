# Описание алгоритмов для понимания основной сути работы:
 
### Алгоритм создания новой фигуры:

| Пользователь  | Система |
| ------------- | ------------- |
| Пользователь нажимает на кнопку «Создать фигуру»  | Создается фигура с тремя вершинами (треугольник) с заданными координатами по умолчанию  |
| Пользователь может изменить расположение фигуры, добавлять вершины и тд  | Отображает результат в интерфейсе |
| Пользователь нажимает на кнопку «Сохранить»  | Система вызывает метод POST /api/v1/figures |


### Алгоритм добавления новой вершины:

| Пользователь  | Система |
| ------------- | ------------- |
| Пользователь нажимает на фигуру, на которую хочет добавить вершину  | Система выделяет выбранную фигуру  |
| Пользователь выбирает ребро фигуры (то есть нажимает на него 2-ПКМ),на которой хочет добавить новую вершину  | В середине этого ребра отображается точка  |
| Пользователь нажимает на появившуюся точку и, удерживая ее, перетягивает в другое место (иначе вершина не будет добавлена к фигуре)  | Точка (новая вершина) перемещается;  Активное ребро (на котором была создана новая вершина) удаляется; Вершины удаленного ребра соединяются с новой вершиной, тем самым образуют новые ребра |
| Пользователь нажимает на кнопку «Сохранить»  | Вызывает метод PUT /api/v1/figures/:id  |


### Алгоритм удаления фигуры:

| Пользователь  | Система |
| ------------- | ------------- |
| Пользователь нажимает на фигуру, которую хочет удалить  | Система выделяет выбранную фигуру  |
| Пользователь нажимает на кнопку «Удалить фигуру» (кнопка не доступна для нажатия, пока не будет выбрана фигура)  | Система вызывает метод DELETE /api/v1/figures/:id  |


### Алгоритм удаления вершины:

| Пользователь  | Система |
| ------------- | ------------- |
| Пользователь нажимает на фигуру, вершину(-ы) которой хочет удалить  | Система выделяет выбранную фигуру  |
| Пользователь нажимает на кнопку «Удалить вершину» (которая не активна, пока не будет выбрана фигура)  | Все вершины (точки) выбранной фигуры меняются на крестики  |
| Пользователь нажимает на вершину-крестик (одну или несколько), которую необходимо удалить  | Система вызывает метод PUT /api/v1/figures/:id; Вершина удаляется, ребра, касающиеся этой вершины, также удаляются; Вершины, оставшиеся без ребер соединяются между собой  |

* Примечание: Фигура не может содержать менее трех вершин.


### Алгоритм изменения расположения вершины:

| Пользователь  | Система |
| ------------- | ------------- |
| Пользователь нажимает на фигуру  | Система выделяет выбранную фигуру  |
| Пользователь нажимает на вершину, которую хочет изменить, и удерживая ее перемещает в другое место  | Система отображает изменения на интерфейсе  |
| Пользователь нажимает на кнопку «Сохранить»  | Система вызывает метод PUT /api/v1/figures/:id  |


### Алгоритм изменения расположения фигуры:

| Пользователь  | Система |
| ------------- | ------------- |
| Пользователь нажимает на фигуру, которую хочет переместить, и удерживая ее перемещает в другое место  | Система выделяет фигуру и отображает изменения на интерфейсе  |
| Пользователь нажимает на кнопку «Сохранить» | Система вызывает метод PUT /api/v1/figures/:id  |


# Описание логики работы методов

### POST /api/v1/figures 

Логика работы:
1. Происходит получение входящих данных и валидация их. Если валидация не пройдена, то возвращается соответствующая ошибка;
2. Данные преобразуются в модель данных для сохранения в БД при помощи транзакции:
	a. Открывается транзакция;
	b. Добавляется запись в таблицу figures;
	c. Добавляется запись в таблиц points по figure_id;
	d. Добавляется запись в таблиц edges по figure_id;
	e. В случае успеха записи происходит коммит транзакции, иначе откат; 
3. В зависимости от результата транзакции возвращается ответ.

### PUT /api/v1/figures/:id

Логика работы метода:
1. Происходит получение входящих данных и валидация их. Если валидация не пройдена, то возвращается соответствующая ошибка;
2. Происходит проверка на существование фигуры в БД по id. Если фигура не найдена, то возвращается соответствующая ошибка;
3. Данные преобразуются в модель данных для сохранения в БД при помощи транзакции:
	a. Открывается транзакция:
	b. Обновляется запись в таблице figures;
	c. Обновляется запись в таблице points по figure_id;
	d. Обновляется запись в таблице edges по figure_id;
	e. В случае успеха записи происходит коммит транзакции, иначе откат; 
4. В зависимости от результата транзакции возвращается ответ.

### DELETE /api/v1/figures/:id

Логика работы: 
1. Происходит получение входящих данных и валидация их. Если валидация не пройдена, то возвращается соответствующая ошибка;
2. Происходит проверка на существование фигуры в БД по id. Если фигура не найдена, то возвращается соответствующая ошибка;
3. Удаляется запись в таблице figures по id;
4. Каскадным методом удаляются записи в таблицах points и edges по figure_id;
5. Возвращается ответ.

### GET /api/v1/figures

Логика работы: 
1. Система отображает все данные из таблиц figures, points и edges.
