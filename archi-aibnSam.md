**1. Vue d'ensemble**

L'architecture repose sur un **API Gateway** qui centralise les requêtes
des clients et les distribue aux différents services. Chaque
microservice possède une API REST et un worker qui gère les tâches
asynchrones.  
L'ensemble repose sur une base de données MySQL avec une mise en cache
Redis et une gestion de messages asynchrones via **RabbitMQ**.

**2. Composants et interactions principales**

**2.1 API Gateway**

L'API Gateway agit comme un point d'entrée unique pour les requêtes des
clients. Il :

- Reçoit les requêtes des utilisateurs via HTTP(S).

- Transmet ces requêtes aux services concernés (Authentication, Payment,
  Booking, etc.).

- Centralise les réponses des microservices avant de les renvoyer aux
  clients.

**2.2 Microservices et leur rôle**

Chaque service est autonome et expose une API REST ainsi qu'un worker.

**Authentication Service**

- Expose une API d'authentification REST pour gérer les connexions et
  les sessions utilisateurs.

- Un worker gère les traitements lourds comme l'envoi d'e-mails de
  validation.

**Payment Service**

- Propose une API pour la gestion des paiements.

- Un worker s'occupe des paiements en arrière-plan pour éviter de
  bloquer les requêtes utilisateurs.

**Booking Service**

- Offre une API pour la gestion des réservations.

- Utilise MySQL via PDO pour stocker les réservations.

- Un worker traite les opérations liées aux réservations en
  arrière-plan.

**User Service**

- Fournit une API REST pour la gestion des utilisateurs.

- Stocke les données utilisateurs dans MySQL.

- Un worker gère les mises à jour en arrière-plan.

- 

**Property Service**

- API REST permettant la gestion des propriétés (ex: ajout,
  modification, suppression).

- Un worker gère les traitements lourds (ex: synchronisation des
  annonces).

**Notification Service**

- Permet l'envoi de notifications via e-mail et SMS.

- 3 workers distincts gèrent l'envoi des e-mails, des SMS et des
  notifications internes.

**Review Service**

- API REST permettant aux utilisateurs de laisser des avis.

- Un worker gère la modération des avis en arrière-plan.

**Message Service**

- API REST pour l'envoi et la gestion des messages entre utilisateurs.

- Un worker gère l'archivage et le routage des messages.

**3. Base de données et cache**

**3.1 MySQL**

Tous les services utilisent une base de données MySQL commune. La
communication s'effectue via PDO (PHP Data Objects).  
Chaque microservice a son propre schéma logique mais peut interagir avec
d'autres tables.

**3.2 Redis Cache**

Un système de cache Redis est utilisé pour :

- Stocker des données temporaires (sessions, résultats de requêtes
  fréquentes).

- Améliorer la rapidité des requêtes en réduisant l'accès à la base de
  données.

**4. Gestion des messages avec RabbitMQ**

RabbitMQ est utilisé pour la communication asynchrone entre services. Il
permet de :

- Gérer les files d'attente pour les tâches lourdes.

- Assurer une communication fluide entre les microservices sans bloquer
  l'API Gateway.

- Optimiser les performances en évitant des appels directs entre
  microservices.

Les workers de chaque service récupèrent les messages dans RabbitMQ pour
exécuter les tâches en arrière-plan.

**5. Avantages de cette architecture**

1.  **Scalabilité** : Chaque service peut être mis à l'échelle
    indépendamment.

2.  **Résilience** : Un service peut tomber sans affecter l'ensemble du
    système.

3.  **Performance** : Les tâches lourdes sont déléguées aux workers pour
    éviter de ralentir les réponses aux utilisateurs.

4.  **Séparation des responsabilités** : Chaque microservice a un rôle
    bien défini, ce qui facilite la maintenance et l'évolution du
    système.

**Conclusion**

Ce schéma représente une architecture de microservices bien organisée
basée sur Laravel 11 et RabbitMQ. Il permet une gestion efficace des
utilisateurs, paiements, réservations et notifications tout en
garantissant des performances élevées grâce à Redis et RabbitMQ.
