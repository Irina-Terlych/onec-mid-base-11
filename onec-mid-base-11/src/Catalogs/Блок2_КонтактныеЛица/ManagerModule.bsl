#Область ОбработчикиСобытий

Процедура ОбработкаПолученияПредставления(Данные, Представление, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	Если ЗначениеЗаполнено(Данные.Блок2_ДействуетНаОсновании) Тогда
		
		Представление = СтрШаблон("%1 (Действует на основании %2)", Данные.Наименование, Данные.Блок2_ДействуетНаОсновании);
		
	Иначе
		
		Представление = Данные.Наименование;
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбработкаПолученияПолейПредставления(Поля, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	Поля.Добавить("Наименование");
	Поля.Добавить("Блок2_ДействуетНаОсновании");
	
КонецПроцедуры

#КонецОбласти