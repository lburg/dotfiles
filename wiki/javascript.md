Javascript
==========

Sources
-------

- https://www.miximum.fr/blog/pour-enfin-comprendre-javascript/

Notions
-------

Javascript n'est pas un langage objet. Il n'y a pas de classe en Javascript.

``this`` et ``arguments`` sont deux arguments passés à chaque fonction lors de son appel :

- ``this`` dépend du contexte d'appel et prend pour valeur l'objet depuis lequel la fonction est appelée

    .. code-block:: javascript

        var person = {
            firstName: 'Bob',
            lastName: 'Sponge',
            fullName: function() {
                return this.firstName + ' ' + this.lastName;
            }
        };
        person.fullName();  // Bob Sponge
        var fn = person.fullName;
        fn(); // undefined undefined, this est l'objet global window ici

- ``arguments`` contient la liste de tous les arguments passés lors de l'appel de la fonction.

Le pattern ``constructor`` permet de créer des objets :

.. code-block:: javascript

    var User = function(firstName, lastName) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.toString = function() {
            return this.firstName + ' ' + this.lastName;
        };
    };
    var tata = new User('Tata', 'de La Rochette de Rochegonde');

L'utilisation de ``new`` est ce qui fait la différence. L'omettre fera que ``this`` sera l'objet global ``window``.

Pour ne pas créer un objet Function par objet User, il faut utiliser le prototype :

.. code-block:: javascript

    var User = function(firstName, lastName) {
        this.firstName = firstName;
        this.lastName = lastName;
    };

    User.prototype.toString = function() {
        return this.firstName + ' ' + this.lastName;
    };

    var tata = new User('Tata', 'de La Rochette de Rochegonde');
    tata.toString();  // Tata de la Rochette de Rochegonde

Les prototypes s'héritent, le chemin de résolution ici est : tata -> User.prototype -> Function.prototype -> Object.prototype.

Il faut utiliser ``apply`` pour hériter du prototype d'un "parent" :

.. code-block:: javascript

    var AnonymousUser = function(firstName, lastName) {
        this.firstName = firstName;
        this.lastName = lastName;
    };

    AnonymousUser.prototype.toString = function() {
        return this.firstName + ' ' + this.lastName;
    };

    var AuthenticatedUser = function() {
        // Ici, on appelle manuellement le constructeur "parent"
        AnonymousUser.apply(this, arguments);
    };
    AuthenticatedUser.prototype = new AnonymousUser();

    AuthenticatedUser.prototype.post_comment = function(comment) {
        // …
    };

Pattern IIFE : Immediately Invoked Function Expression. Permet de définir des modules capables d'exporter plusieurs
objets à la fois comme ils le souhaitent :

.. code-block:: javascript

    (function(exports) {
        var PASSWORD = 'gloubiboulga';

        var User = function(firstName, lastName) {
            this.firstName = firstName;
            this.lastName = lastName;
            this.isAuthenticated = false;
        };
        exports.User = User;

        User.prototype.toString = function() {
            return this.firstName + ' ' + this.lastName;
        };

        User.prototype.authenticate = function(password) {
            if (password == PASSWORD) {
                this.isAuthenticated = true;
            }
        };
    })(this);
