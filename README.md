# Transportation App
The applocaiton was created as graduation work and design to manage transportation process. The application is written in C++ with a graphical interface in Qt QML and is based on a modular architecture.

## Download and build
Clone project: 
```
git clone https://github.com/k0luchiy/TransportationApp.git
cd TransportationApp
```
Build project:
```
cmake . -B build
```

## Project architecture
Project based on module architecture, so all components and classes put in a libraries. 

<picture>
 <source media="(prefers-color-scheme: dark)" srcset="https://github.com/k0luchiy/TransportationApp/assets/83074096/c325f4a3-d841-41ad-96cc-843e1c865259">
 <source media="(prefers-color-scheme: light)" srcset="https://github.com/k0luchiy/TransportationApp/assets/83074096/6fcf7b86-0754-4057-a665-2208281cdc53">
 <img alt="Project structure image" src="https://github.com/k0luchiy/TransportationApp/assets/83074096/c325f4a3-d841-41ad-96cc-843e1c865259">
</picture>

## Database architecture 
Database contatins multiple tables main of witch: users, orders, deliveries, cars and drivers.

<picture>
 <source media="(prefers-color-scheme: dark)" srcset="https://github.com/k0luchiy/TransportationApp/assets/83074096/242a8e8c-4114-4ec3-8499-7b1768d9e224">
 <source media="(prefers-color-scheme: light)" srcset="https://github.com/k0luchiy/TransportationApp/assets/83074096/2d2f5316-6ec5-4ebe-81a8-b381ce4fce91">
 <img alt="ER-diagram of a database." src="https://github.com/k0luchiy/TransportationApp/assets/83074096/242a8e8c-4114-4ec3-8499-7b1768d9e224">
</picture>

## Examples 
### Authorization
First thing that user sees is authorization page, with possibility to open registration page. 

<picture>
 <source media="(prefers-color-scheme: dark)" srcset="https://github.com/k0luchiy/TransportationApp/assets/83074096/e27578e2-0847-4e64-9a95-ccbb2d281588">
 <source media="(prefers-color-scheme: light)" srcset="https://github.com/k0luchiy/TransportationApp/assets/83074096/fbed1fe2-1c52-403d-aa58-4d1057504d5a">
 <img alt="Screenshot of the authorization page." src="https://github.com/k0luchiy/TransportationApp/assets/83074096/e27578e2-0847-4e64-9a95-ccbb2d281588">
</picture>

### Main page
Main page of applicaiton contains multiple pages, such as: orders, cars, drivers, deliveries and planning. Most pages consists of table with basic filters, pagination and top menu.

<picture>
 <source media="(prefers-color-scheme: dark)" srcset="https://github.com/k0luchiy/TransportationApp/assets/83074096/d911f122-0ee5-4fcd-9036-5d5039194897">
 <source media="(prefers-color-scheme: light)" srcset="https://github.com/k0luchiy/TransportationApp/assets/83074096/aeaee3b1-5c48-43a4-a29e-088d7c6b8ed3">
 <img alt="Screenshot of the main page." src="https://github.com/k0luchiy/TransportationApp/assets/83074096/d911f122-0ee5-4fcd-9036-5d5039194897">
</picture>

### Settings 
The application also contains settings that allows user information editing, password reset, changind theme and language.

<picture>
 <source media="(prefers-color-scheme: dark)" srcset="https://github.com/k0luchiy/TransportationApp/assets/83074096/e4288be6-c798-4dcd-8cf1-4c0d5ecbff12">
 <source media="(prefers-color-scheme: light)" srcset="https://github.com/k0luchiy/TransportationApp/assets/83074096/687bde1f-d04b-4d2c-a9e8-623a9671ebba">
 <img alt="Screenshot of the settings." src="https://github.com/k0luchiy/TransportationApp/assets/83074096/e4288be6-c798-4dcd-8cf1-4c0d5ecbff12">
</picture>