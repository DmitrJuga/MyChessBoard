# ![](https://github.com/DmitrJuga/MyChessBoard/blob/master/MyChessBoard/Images.xcassets/AppIcon.appiconset/Checkerboard-29@2x.png)  Шахматная доска / My Chess Board

**"Шахматная доска"** - простой симулятор шахматный доски. Учебная задача на **Objective-C** (*работа c кастомными view, обработка touch-касаний, анимация*).

![](https://github.com/DmitrJuga/MyChessBoard/blob/master/screenshots/screenshot1.png)
![](https://github.com/DmitrJuga/MyChessBoard/blob/master/screenshots/screenshot2.png)


## Функционал

- Реализовано перемещение (пертягивание) фигур в свободные клетки.
- Если клетка занята - фигура возвращается в исходную клетку.
- При перетягивании за пределы поля - фигура возвращается в исходную клетку.
- Фигура всегда становится по центру клетки, в которую её перемещают.
- Анимация: при перемещении фигура увеличивается и становится полупрозрачной.
- Автоматический разворот поля и фигур при повороте устройства.
- Поддерживаются устройства всех размеров, но рекомендуется iPad.


## Техническая информация

- Всё реализовано в коде, без интерфейс-билдера.
- Используются кастомные view (наследники `UIView` с переопределёнными `drawRect:` и `layoutSubviews`) для отрисовки доски (класс `DDBoard`) и фигур (класс `DDFigure`).
- Перемещение фигур реализовано путем обработки касаний (*touch-событий*); методы: `touchesBegan:withEvent:`, `touchesMoved:withEvent:`, `touchesEnded:withEvent:`, `touchesCancelled:withEvent:`).
- В качестве изображения фигур используется unicode-символы.


## Основа проекта

Проект создан на основе моей домашней работы к уроку 2 по курсу **"Objective C. Уровень 2"** в [НОЧУ ДО «Школа программирования» (http://geekbrains.ru)](http://geekbrains.ru/) и доработан после окончания курса. Домашнее задание и пояснения к выполненой работе - см. в [homework_readme.md](https://github.com/DmitrJuga/MyChessBoard/blob/master/homework_readme.md).

---

### Contacts

**Дмитрий Долотенко / Dmitry Dolotenko**

Krasnodar, Russia   
Phone: +7 (918) 464-02-63   
E-mail: <dmitrjuga@gmail.com>   
Skype: d2imas

:]

