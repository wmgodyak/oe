*Синхронізація каталогу і замовлень з 1C*
Написано на основі:
Протокол обмена между системой "1С:Предприятие" и сайтом
http://v8.1c.ru/edi/edi_stnd/131/

Обмін складається з двох блоків
 - обмін товарними запасами
 - обмін замовленнями 
 
 Уточнення, синхронізація відбувається в односторонньому порядку. 
 Тобто всі запити поислає 1С. Проте обмін замовлень двонапрямлений. 
 Тобто замовлення, створені на стороні 1С будуть створюватись на сайті 
 автоматично.  
 
 Відповідь сайту в форматі text/plain . Рядки розділені символом "\n" 
  
  перший рядок - статус success | failure (успіх | помилка)
  наступні рядки - додатк інформація.
  
  
 
 **Обмін товарними запасами 1С -> Сайт**
 
 1. Початок сеансу. Авторизація. 1с посилає запит на сайт по вказаному урл.
 В параметрах запиту потрібно відправити логін і пароль
 
 http://e7.otakoyi.com/route/exchange1c/run?type=catalog&mode=checkauth
 
 Логін: 1c-ex-user
 Пароль: 2tsbrruj1ms11nk6gifc4r54g3
 
 
 У відповідь сайт посилає:
 success
 
 oyiengine
 6e98ac5bb0cc5b9d3e9b9095c9868264 унікальний для однієї сесії
 
 , їх потрібно передавати в наступних запитах.
 
 2. Запит параметрів сайту. 
 
 http://e7.otakoyi.com/route/exchange1c/run?type=catalog&mode=init
 
 Відповідь
 zip=yes|no
 file_limit=1024
 , де file_limit - допустимий розмір файлу в байтах
 
 3. Завантаження файлу на сайт
 
 http://e7.otakoyi.com/route/exchange1c/run?type=catalog&mode=file&filename=kategorii.csv
 http://e7.otakoyi.com/route/exchange1c/run?type=catalog&mode=file&filename=tovaru.csv
  
  де kategorii.csv назва файлу
  вміст файлу передається у вигляді POST даних
  
  Допустимі файли 
  kategorii.csv | tovaru.csv
  
  4. Завантаження даних 
  
 http://e7.otakoyi.com/route/exchange1c/run?type=catalog&mode=import&filename=kategorii.csv
 http://e7.otakoyi.com/route/exchange1c/run?type=catalog&mode=import&filename=tovaru.csv
 
 Відповідь
 success | failure
 
 в наст рядках деталі, якщо є. Наприклад вміст помилки
  
 Послідовність запитів.
 
 1.2.3.4 . Зверніть увагу, обовязково відправляйте нові категорії на сайт.
  Якщо товар прикріплений до категорії, якої немає на сайті, то отримаєте помилку. Опис помилок буде нижче.
   
   П.2 - необовязковий.
  
 **Обмін замовленнями**
  
   1. Початок сеансу. 
   
   http://e7.otakoyi.com/route/exchange1c/run?type=sale&mode=checkauth
   
   2. Запит параметрів сайту. 
   http://e7.otakoyi.com/route/exchange1c/run?type=sale&mode=init
   
   3. Отримання замовлень з сайту
   
   - список замовлень 
   http://e7.otakoyi.com/route/exchange1c/run?type=sale&mode=orders
   
   у відповідь ви отримаєте дані в форматі .csv

   Обовяхково передавайте першим рядком назви колонок
   id;external_id;oid;status;one_click;user_id;users_group_id;user_name;user_surname;user_phone;user_email;currency;currency_rate;amount;comment;created;paid;paid_date;payment_id;delivery_id;delivery_cost;delivery_address
   
   - список товарів в замовленнях
   http://e7.otakoyi.com/route/exchange1c/run?type=sale&mode=products
   
   orders_id,external_id,products_id,sku,products_name,quantity,price
   
   Примітка. Після завантаження замовлень, ідправте запит на сайт з mode=success 
   
   - замовлення збережено
   http://e7.otakoyi.com/route/exchange1c/run?type=sale&mode=success
   
   це означатиме що замовлення цспішно завантажені.
    Система відмітить дані замовлення і не буде відправляти в майбутньому
    
   4. Завантаження файлу з замовленнями на сайт
   
 http://e7.otakoyi.com/route/exchange1c/run?type=sale&mode=file&filename=orders.csv
 http://e7.otakoyi.com/route/exchange1c/run?type=sale&mode=file&filename=orders_products.csv
  
  де orders.csv назва файлу з замовленнями
  orders_products.csv - товари в замовленні
  
  5. Завантаження даних 
  
 http://e7.otakoyi.com/route/exchange1c/run?type=sale&mode=import&filename=orders.csv
 http://e7.otakoyi.com/route/exchange1c/run?type=sale&mode=import&filename=orders_products.csv
 
 Примітка. Завантажте два файли на сайт: orders.csv потім orders_products.csv , тоді запускайте import
 
 В замовлення додано поле external_id - це ід замовлення в 1с. Якщо на стороні 1с створено замовлення, то 
 поле ід повинно бути пустим а поле external_id заповненим. Системо створить замовлення і присвоїть йому відповідний ід.
 
 Якщо замовлення створено на стороні сайту , то поле external_id буде пустим. 
 Воно буде заповнено значенням яке буе присвоєно йому в 1с.
 
 **Коди помилок**
 
 - EX001 - Виклик неіснуючої моделі.
 - EX002 - Виклик неіснуючого методу моделі.
 - EX003 - Невірні дані авторизації
 - EX004 - Невірне значення куки. Термін дії куки вийшов
 - EX005 - Запрошуємий файл не існує
 - EX006 - Пустий POST
 - EX007 - Помилка збереження файлу 
 - EX008 - Помилка в процесі розпакування архіву
 - EX009 - Помилка в процесі імпорту категорій
 - EX010 - Помилка в процесі імпорту товару
 - EX011 - Здійснено запит товари в замовленні, проте невідомо для яких замовлень
 - EX012 - Здійснено підтвердження про збереження замовлень, без попереднього виклику даних про замовлення
 - EX013 - Невірний статус замовлення. В замовленні передано статус, який відсутній в системі.
 - EX014 - Невірний ід покупця. В замовленні передано ід покупця який відсутній в системі. Для нових покупців передавайте 0 або пустоту
 - EX015 - Помилка при створенні замовлення
 - EX016 - Невірний ід замовлення 
 - EX017 - Помилка при створенні замовлення. Пустий ід і external_id в файлі з товарами
 - EX018 - Невірний external_id в файлі з товарами
 - EX019 - При створенні товару в замовленні виникла помилка
 - EX020 - При оновленні товару виникла помилка.
 
 
 Зауваження. Для тестування я вимкнув авторизацію. 