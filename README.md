# AtomKot
Flutter-прмложение "Робокот" для Atomverse Store.

# Ночной водитель
Это ассистент, который раз в несколько минут будит водителя специальным звуком. Система случайным образом выбирает кнопку для подтвержения (+ или -), чтобы водитель не мог обманывать её машинальными движениями, после чего отображает на экране анимацию, в какую сторону необходимо двинуть джойстик на руле. Джойстиком водитель подтверждает своё бодрствование (убавляет или увеличивает громкость на одно деление, в приложении есть handler, который это отслеживает), после чего сирена отключается.

![Alarm](https://github.com/Geolan84/AtomKot/blob/main/screenshots/НочнойВодитель.gif)
 

# Советы при ДТП
Этот раздел содержит текстовые заметки, как оказать первую помощь, а также кнопку для определения местоположения и быстрого звонка в скорую. Приложение использует geolocator для определения координат, после чего через API обращается к сервису dadata, где преобразует координаты в близлежащий адрес. Кнопка "Вызвать скорую" перенаправляет водителя в приложение "Телефон" с уже набранным номером 112.

![Help](https://github.com/Geolan84/AtomKot/blob/main/screenshots/Совет.gif)
 

# Игра
Игра-арканоид для развлечения в пробках или на зарядке.

![Game](https://github.com/Geolan84/AtomKot/blob/main/screenshots/Игра.gif)


