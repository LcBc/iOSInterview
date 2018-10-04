Las capas de la aplicación son las siguientes:
-Capa de Red 
MovieRequestManager.swift: esta clase se encarga de realizar las consultas remotas a los servicios REST del API.
-Capa de Persistencia:
Movie.swift: Esta clase se encarga de almacenar la información de las películas.
Genre.swift: Esta clase se encarga de almacenar la información de los géneros.
-Capa de negocios:
MovieRepository.swift: Esta Clase se encarga de almacenar las películas en la capa de persistencia y de realizar las consultas sobre películas.
GenreRepository.swift: Esta Clase se encarga de almacenar las películas en la capa de persistencia y de realizar las consultas sobre géneros.
-Capa de vista:
OnlineTableViewController: Esta vista presenta la información en linea sobre las películas.
OffLineTableViewController: Esta vista presenta la información guarda en el cache de la aplicación.
MovieTableViewCell: Esta la clase para administrar las celdas de la lista de películas
DetailViewController: Esta clase es de la vista donde se muestra el detalle de las películas



El principio de responsabilidad única se basa en que un modulo o clase tiene una única responsabilidad dentro de la aplicación , se utiliza para fortalecer el encapsulamiento y debilitar el acoplamiento de las clases, haciendo que cuando en el momento que se necesite realizar un cambio afecte lo menos posible el resto de la aplicación.

Un buen código o código limpio, es aquel que deja de manera bastante clara la intención del autor respecto al funcionamiento del mismo.
