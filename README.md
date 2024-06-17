# Transportation App
The applocaiton was created as graduation work and design to manage transportation process. The application is written in C++ with a graphical interface in Qt QML and is based on a modular architecture.

## Download and build
Clone project: 
'''
git clone https://github.com/k0luchiy/TransportationApp.git
cd TransportationApp
'''
Build project:
'''
cmake . -B build
'''

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
![Screenshot of the authorization page.](https://github.com/k0luchiy/TransportationApp/assets/83074096/9b77415e-5a9f-48d6-bb9f-608f6887cc4c)

### Main page
Main page of applicaiton contains multiple pages, such as: orders, cars, drivers, deliveries and planning. Most pages consists of table with basic filters, pagination and top menu.
![Screenshot of the main page.](https://github.com/k0luchiy/TransportationApp/assets/83074096/cd77087d-c9a6-4c48-a2bd-92a61cf2ea76)

### Settings 
The application also contains settings that allows user information editing, password reset, changind theme and language.
![Screenshot of the settings.](https://github.com/k0luchiy/TransportationApp/assets/83074096/23f06147-1489-498f-8650-bd579a984706)