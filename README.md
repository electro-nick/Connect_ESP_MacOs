# Connect_ESP_MacOs

Автор: **[YouTube Канал](https://www.youtube.com/channel/UCM-XygZwEYf7gJTsNsHrFew)**, **[Группа ВК](https://vk.com/public_electro_nick)**, **[Сайт с проектами](http://electro-nick.ru)**

![](https://github.com/electro-nick/Connect_ESP_MacOs/blob/master/Images/app.png)

Для начала необходимо объявить и инициализировать класс **[UDP](https://github.com/electro-nick/Connect_ESP_MacOs/blob/master/SketchApp/UDP.swift)** для общения с **ESP**.

Первое что необходимо это объявить переменную класса udp **вне метода func viewDidLoad()**:

`var udp: UDP? = nil`

Далее инициализируем класс, прописываем айпи и порт, и передаем слушатель как параметр функции:

_Айпи мы прописывали в arduino IDE. Он статичен._

### Инициализация:
* `udp = UDP(ip: "192.168.0.187", port: 4210, onSuccess: { stateServer in ... })`

* `onSuccess: { stateServer in ... }` - это слушатель. Тут ловим ответ от ESP. [Смотреть пример](https://github.com/electro-nick/Connect_ESP_MacOs/blob/master/SketchApp/ViewController.swift). 25 строка!

Внутри есть метод `DispatchQueue.main.async { }`. Он нужен для того, что бы обновлять визуал внутри другого потока.

### Методы:
1. `func send( key: String, value: String, onError: @escaping ( String ) -> Void)`

`onError: @escaping ( String ) -> Void)` - Мы просто отправляем функцию как параметр. Она вызывается, если возникает ошибка при отправке. Возвращает тип String.

### Описание:
1. Отправка строки на ESP

### Примеры:

1. `udp?.send(key: "power", value: "1", onError: { err in print(err) })` - Включить лампу.
2. `udp?.send(key: "brightness", value: "60", onError: { err in print(err) })` - Установить яркость лампы. от 0 до 255.
3. `udp?.send(key: "mode", value: "2", onError: { err in print(err) })` - Установить 2 режим работы лампы.
4. `udp?.send(key: "color", value: "255 0 0", onError: { err in print(err) })` - Установить цвет лампы в формате RGB.
5. `udp?.send(key: "getPowerState", value: "", onError: { err in print(err) })` - Получить ответ из ESP. Тут уже сложнее. Более подробно описано ниже.

Прописываем таймер, который будет вызываться каждые 2 секунды:

* `Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true, block: {_ in ... })`

Далее внутри вызываем функцию, которая будет сообщать ESP что мы хотим получить данные от нее:

* `self.udp?.send(key: "getPowerState", value: "", onError: { err in print(err) })`

Далее ловим ответ в конструкторе и меняем состояние вьюхи. [Смотреть пример](https://github.com/electro-nick/Connect_ESP_MacOs/blob/master/SketchApp/ViewController.swift). 25 строка!

