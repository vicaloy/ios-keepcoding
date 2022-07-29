//
//  DBCharacterRepository.swift
//  DragonBallApp
//
//  Created by Victoria Aloy on 28/7/22.
//

import Foundation

class DBCharacterRepository {
    var dbCharacterSample: DBCharacters {
        [Hero(name: "Maestro Roshi", description: "Es un maestro de artes marciales que tiene una escuela, donde entrenará a Goku y Krilin para los Torneos de Artes Marciales. Aún en los primeros episodios había un toque de tradición y disciplina, muy bien representada por el maestro. Pero Muten Roshi es un anciano extremadamente pervertido con las chicas jóvenes, una actitud que se utilizaba en escenas divertidas en los años 80. En su faceta de experto en artes marciales, fue quien le enseñó a Goku técnicas como el Kame Hame Ha", photo:
                URL(string: "https://cdn.alfabetajuega.com/alfabetajuega/2020/06/Roshi.jpg?width=300")!, id: "14BB8E98-6586-4EA7-B4D7-35D6A63F5AA3", score: 5.5),
         Villain(name: "Vegeta",
                 description: "Vegeta es todo lo contrario. Es arrogante, cruel y despreciable. Quiere conseguir las bolas de Dragón y se enfrenta a todos los protagonistas, matando a Yamcha, Ten Shin Han, Piccolo y Chaos. Es despreciable porque no duda en matar a Nappa, quien entonces era su compañero, como castigo por su fracaso. Tras el intenso entrenamiento de Goku, el guerrero se enfrenta a Vegeta y estuvo a punto de morir. Lejos de sobreponerse, Vegeta huye del planeta Tierra sin saber que pronto tendrá que unirse a los que considera sus enemigos.",
                 photo: URL(string: "https://cdn.alfabetajuega.com/alfabetajuega/2020/12/vegetita.jpg?width=300")!,
                 id: "6E1B907C-EB3A-45BA-AE03-44FA251F64E9",
                 evil: 8.7),
         Hero(name: "Krilin", description: "Krilin lo tiene todo. Cuando aún no existían los 'memes', Krilin ya los protagonizaba. Junto a Yamcha ha sido objeto de burla por sus desafortunadas batallas en Dragon Ball Z. Inicialmente, Krilin era el mejor amigo de Goku siendo sólo dos niños que querían aprender artes marciales. El Maestro Roshi les entrena para ser dos grandes luchadores, pero la diferencia entre ambos cada vez es más evidente. Krilin era ambicioso y se ablanda con el tiempo. Es un personaje que acepta un papel secundario para apoyar el éxito de su mejor amigo Goku de una forma totalmente altruista.", photo:
                URL(string: "https://cdn.alfabetajuega.com/alfabetajuega/2020/08/Krilin.jpg?width=300")!,
              id: "D88BE50B-913D-4EA8-AC42-04D3AF1434E3",
              score: 5.5),
         Villain(name: "Mr. Satán",
                 description: "Mr. Satán es un charlatán fanfarrón, capaz de manipular a las masas. Pero en realidad es cobarde cuando se da cuenta que no puede contra su adversario como ocurrió con Androide 18 o Célula. Siempre habla más de la cuenta, pero en algún momento del combate empieza a suplicar. Androide 18 le ayuda a fingir su victoria a cambio de mucho dinero. Él acepta el trato porque no podría soportar que todo el mundo le diera la espalda por ser un fraude.",
                 photo: URL(string: "https://cdn.alfabetajuega.com/alfabetajuega/2020/06/dragon-ball-satan.jpg?width=300")!,
                 id: "1985A353-157F-4C0B-A789-FD5B4F8DABDB",
                 evil: 4.7),
         Hero(name: "Goku", description: "Sobran las presentaciones cuando se habla de Goku. El Saiyan fue enviado al planeta Tierra, pero hay dos versiones sobre el origen del personaje. Según una publicación especial, cuando Goku nació midieron su poder y apenas llegaba a dos unidades, siendo el Saiyan más débil. Aun así se pensaba que le bastaría para conquistar el planeta. Sin embargo, la versión más popular es que Freezer era una amenaza para su planeta natal y antes de que fuera destruido, se envió a Goku en una incubadora para salvarle.", photo:
                URL(string: "https://cdn.alfabetajuega.com/alfabetajuega/2020/12/goku1.jpg?width=300")!, id: "D13A40E5-4418-4223-9CE6-D2F9A28EBE94", score: 10.0),
         Villain(name: "Freezer",
                 description: "Freezer es el villano más temido del universo Dragon Ball, es la maldad personificada. Es el responsable de la muerte de los padres de Goku, del Rey Vegeta, de los Saiyan del Planeta Vegeta, donde provocó un genocidio. La serie mostró en varias ocasiones su crueldad, ya que disfruta de la muerte y del sufrimiento de sus víctimas. Y no tiene límites. Freezer es la razón por la que Vegeta termina uniéndose a Goku. Tanto Vegeta como Freezer desean la inmortalidad, así que ambos compiten por reunir las bolas de Dragón. Finalmente todos se enfrentan a él. El propio Piccolo es resucitado y trasladado a Namek para enfrentarse al villano. Pronto revelará que tiene varias transformaciones más poderosas, siendo la forma final la más fuerte de todas. Trunks del Futuro consigue matarle, aunque más tarde será revivido para volver a dar guerra en Dragon Ball Super.",
                 photo: URL(string: "https://cdn.alfabetajuega.com/alfabetajuega/2020/12/freezer-dragon-ball-bebe-abj.jpg?width=300")!,
                 id: "D13991A5-6E61-4554-8AA9-D35D0CF3DE58",
                 evil: 7.7)]
    }
}



