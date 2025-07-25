  
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
    // СтандартныеПодсистемы.ПодключаемыеКоманды
    ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
    // Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
    // СтандартныеПодсистемы.ПодключаемыеКоманды
    ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
    // Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
    ПодключаемыеКомандыКлиент.ПослеЗаписи(ЭтотОбъект, Объект, ПараметрыЗаписи);
КонецПроцедуры

#КонецОбласти


#Область ОбработчикиСобытийЭлементовШапкиФормы

// (( Ирина Добавляю вопрос пользователю и возможность перерасчета в случае ответа "Да" 
&НаКлиенте
Асинх Процедура Блок2_СогласованнаяСкидкаПриИзменении(Элемент) 
	
	Если Не ЗначениеЗаполнено(Объект.Товары) И Не ЗначениеЗаполнено(Объект.Услуги) Тогда
		Возврат;
	КонецЕсли;	
	
	Вопрос = "Процент скидки изменился, вы хотите произвести перерасчет табличной части?";
	Обещание = ВопросАсинх(Вопрос, РежимДиалогаВопрос.ДаНет, , КодВозвратаДиалога.Да);
	Результат = Ждать Обещание;
	
	Если Результат = КодВозвратаДиалога.Да Тогда    
		
		ПересчитатьПоДаннымСкидки();
		
	КонецЕсли; 
	
КонецПроцедуры 
 // )) Ирина
 
 #КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыТовары

&НаКлиенте
Процедура ТоварыКоличествоПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыЦенаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыПриИзменении(Элемент)
	РассчитатьСуммуДокумента();
КонецПроцедуры

&НаКлиенте
Процедура ТоварыСкидкаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыУслуги

&НаКлиенте
Процедура УслугиКоличествоПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Услуги.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура УслугиЦенаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Услуги.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура УслугиСкидкаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Услуги.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура УслугиПриИзменении(Элемент)
	РассчитатьСуммуДокумента();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

// (( Ирина Добавляю действие команды "Пересчитать"
&НаКлиенте
Процедура Блок2_Пересчитать(Команда) 

	ПересчитатьПоДаннымСкидки();

КонецПроцедуры 
   
   // )) Ирина
   
#КонецОбласти   

#Область СлужебныеПроцедурыИФункции

// (( Ирина Процедура перерасчета суммы с учетом новой скидки
&НаКлиенте
Процедура ПересчитатьПоДаннымСкидки()    
	
	Для Каждого Строка Из Объект.Товары Цикл  
		
		РассчитатьСуммуСтроки(Строка); 
		
	КонецЦикла;   	
	
	Для Каждого Строка Из Объект.Услуги Цикл 	
		
		РассчитатьСуммуСтроки(Строка); 
		
	КонецЦикла; 
	
КонецПроцедуры   
  // )) Ирина  

&НаКлиенте
Процедура РассчитатьСуммуСтроки(ТекущиеДанные)
	
	   // ((Ирина Меняем формулу с учетом скидки    
	
	//КоэффициентСкидки = 1 - ТекущиеДанные.Скидка / 100;
	//ТекущиеДанные.Сумма = ТекущиеДанные.Цена * ТекущиеДанные.Количество * КоэффициентСкидки;
			
	СкидкаИтогоПоСтроке = ТекущиеДанные.Скидка + Объект.Блок2_СогласованнаяСкидка;  
	
	Если СкидкаИтогоПоСтроке < 100 ИЛИ СкидкаИтогоПоСтроке = 100 Тогда 		
		КоэффициентСкидки = 1 - (ТекущиеДанные.Скидка + Объект.Блок2_СогласованнаяСкидка) / 100;
		ТекущиеДанные.Сумма = ТекущиеДанные.Цена * ТекущиеДанные.Количество * КоэффициентСкидки;
	Иначе
		Сообщение = Новый СообщениеПользователю();
        Сообщение.Текст = СтрШаблон("Процент скидки не может быть более 100, скидка по строке составила %1, уточни скидку по %2", СкидкаИтогоПоСтроке, ТекущиеДанные.Номенклатура);
        Сообщение.Сообщить();
		ТекущиеДанные.Сумма = 0;  
	КонецЕсли; 		
	// ))Ирина
	
КонецПроцедуры

&НаКлиенте
Процедура РассчитатьСуммуДокумента()
	
	Объект.СуммаДокумента = Объект.Товары.Итог("Сумма") + Объект.Услуги.Итог("Сумма");
	
КонецПроцедуры

#Область ПодключаемыеКоманды

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
    ПодключаемыеКомандыКлиент.НачатьВыполнениеКоманды(ЭтотОбъект, Команда, Объект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПродолжитьВыполнениеКомандыНаСервере(ПараметрыВыполнения, ДополнительныеПараметры) Экспорт
    ВыполнитьКомандуНаСервере(ПараметрыВыполнения);
КонецПроцедуры

&НаСервере
Процедура ВыполнитьКомандуНаСервере(ПараметрыВыполнения)
    ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, ПараметрыВыполнения, Объект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
    ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

#КонецОбласти

#КонецОбласти
