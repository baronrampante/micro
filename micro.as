package 
{

	/* 
	INDICE:
	IMPORT
	VARIABLES
	INICIO
	BARRACA
	ASERRADERO
	CLIENTES
	*/
	//fffff

	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.text.*;
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	import fl.transitions.TweenEvent;


	public class micro extends MovieClip
	{
		public var _timer:Timer = new Timer(1000);// se ejecuta cada un segundo
		public var _timer_trabajo:Timer = new Timer(Tiempo_construccion);// definimos cuanto es el tiempo de mareo
		public var _timer_espera_cliente:Timer = new Timer(1000);// se ejecuta cada un segundo
		private var _tiempo_jugado:uint = 0;
		private var _tiempo_para_jugar:uint = 50;// definir el tiempo total aca


		public var cala_little_var = 0;
		public var cala_big_var = 0;
		public var Pintura_var = 0;

		//hijos

		var Empezar_Laburo_BT:Empezar_BT = new Empezar_BT();


		//variables botones stage

		public var Dinero_var = 12000;
		public var Comunidad_var = 600;
		public var Dia_var = 1;
		public var Semana_var = 1;
		public var Hora_var = 1;
		public var Hora_Dia_var = 0;// se incrementa cada hora
		public var Horas_para_Dia = 12;// variable que determina el día
		public var Dias_para_Semana = 5;// variable que determina duracion semana
		public var Dia_Semana = 0;// variable que cuenta los dias para llegar a a la semana
		public var Cuota_Banco = 3000;
		public var Gastos_Fijos = 1500;
		var Sueldos = 0;
		var Gastos_Personales = 500;


		//variables compras

		var Alfajias_var_Numb:Number = 0;
		var Tablones_var_Numb:Number = 0;
		var Resultado_Maderas_var = 0;
		var Alfajias_Stock = 0;
		var Tablones_Stock = 0;

		//precios

		var Alfajias_precio = 100;
		var Tablones_precio = 300;
		var Caladora_precio = 1000;
		var Taladro_banco_precio = 3000;
		var Cafetera_precio = 1500;
		var Mesa_Combinada_precio = 3000;
		var Pinturas_precio = 1000;
		var Caladora_Pie_precio = 4000;
		var Taladro_Pie_precio = 3000;


		//Clientes
		var Nuevo_Cliente = 0;
		var Viejo_Cliente = 100;
		var Producto_var = "Silla";
		var Velocidad_var = 6;
		var Cliente_var = "Vieja";
		var Cliente_cara = "Placa_Clientes.Punk_MC";
		var Cliente_on_Stage = false;
		var coso;//variable lista d eclientes
		var Nombre_Cliente = "Mormon";



		// arrays clientes pedidos orden_= Precio, Alfajías, Tablones, Tiempo en horas, Cliente [4]
		var Eleccion_Trabajos:Array = new Array();
		var Silla:Array = new Array(500,1,1,4,"Silla","necesito me arregles la silla","Que pasa tio");
		var Cama:Array = new Array(1200,2,2,12,"Cama","necesito me arregles la cama","Que cojones");
		var Mesa:Array = new Array(1000,2,3,8,"Mesa","necesito me arregles la mesa","Que mierda");
		var Taburete:Array = new Array(800,2,3,8,"Taburete","necesito me arregles el Taburete","Upiis");
		var Reposera:Array = new Array(1300,2,3,8,"Reposera","necesito me arregles la Reposera","Que mierda");

		var Elementos:Array = new Array(Silla,Mesa,Cama,Taburete,Reposera);
		var nombre = 0;// extrae el nombre de los productos del array de productos  Elementos

		// array de trabajos
		var Trabajos:Array = new Array ();
		var Tiempo_construccion = 1000;
		var Tiempo_total_arreglo = 0;
		var Producto_Viejo = 0;

		// flags
		var Trabajo_en_Curso = false;

		// Super inicio de todo

		public function micro()
		{
			_timer.start();
			init();
		}

		// Genera un random
		public function randomRange(minNum:Number, maxNum:Number):Number
		{
			return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
		}


		public function init():void
		{
			//trace(Producto_var);
			Dinero.text = String(Dinero_var);
			Comunidad.text = String(Comunidad_var);
			Horas.text = String(_timer.currentCount) + "  horas";
			Semana.text = String(Semana_var);
			Dia.text = String(Dia_var);

			//clientes
			Lista_Trabajos.Mormon_MC.visible = false;
			Lista_Trabajos.Vieja_MC.visible = false;
			Lista_Trabajos.Nena_MC.visible = false;
			Lista_Trabajos.Coqueta_MC.visible = false;
			Lista_Trabajos.Punk_MC.visible = false;
			Lista_Trabajos.Viejo_MC.visible = false;
			Placa_Clientes.Mormon_MC.visible = false;
			Placa_Clientes.Vieja_MC.visible = false;
			Placa_Clientes.Nena_MC.visible = false;
			Placa_Clientes.Coqueta_MC.visible = false;
			Placa_Clientes.Punk_MC.visible = false;
			Placa_Clientes.Viejo_MC.visible = false;
			Punk.visible = false;
			Mormon.visible = false;
			Punk.visible = false;
			Vieja.visible = false;
			Viejo.visible = false;
			Coqueta.visible = false;
			Nena.visible = false;


			// herramientas
			cala_big.visible = false;
			cala_little.visible = false;
			Cafetera_Chica.visible = false;
			Caladora_de_Pie.visible = false;
			Combinada_MC.visible = false;
			Lata_Pintura_MC.visible = false;

			//pantallas
			Placa_Clientes.visible = false;
			Lista_Trabajos.visible = false;
			Barra.visible = false;
			Madera_MC.visible = false;
			Placa_financiera.visible = false;
			Barrio.visible = false;

			//clientes creación
			//fnCrear_Clientes();

			//botones
			Placa_Clientes.Yes_BT.addEventListener(MouseEvent.MOUSE_DOWN, Clientes_Pedido);
			Ir_Barraca.addEventListener(MouseEvent.MOUSE_DOWN, En_Barraca);
			Ir_Madera.addEventListener(MouseEvent.MOUSE_DOWN, En_Madera);
			Lista_Trabajos.Cerrar_BT.addEventListener(MouseEvent.MOUSE_DOWN, fnCerrarLista);
			Financiera_BT.addEventListener(MouseEvent.MOUSE_DOWN, fnPlaca_Financiera);
			Placa_financiera.btn_cerrar.addEventListener(MouseEvent.MOUSE_DOWN, fnPlaca_Financiera_Cerrar);
			Lista_Trabajos.addEventListener(MouseEvent.MOUSE_DOWN, fnBotones_Trabajos);
			/*Lista_Trabajos.Array_Trabajos1.addEventListener(MouseEvent.MOUSE_DOWN, fnBotones_Trabajos);
			Lista_Trabajos.Array_Trabajos2.addEventListener(MouseEvent.MOUSE_DOWN, fnBotones_Trabajos);
			Lista_Trabajos.Array_Trabajos3.addEventListener(MouseEvent.MOUSE_DOWN, fnBotones_Trabajos);
			Lista_Trabajos.Array_Trabajos4.addEventListener(MouseEvent.MOUSE_DOWN, fnBotones_Trabajos);
			Lista_Trabajos.Array_Trabajos1.addEventListener(MouseEvent.MOUSE_DOWN, fnBotones_Trabajos);*/

			Barrio.Comunidad_Cerrar.addEventListener(MouseEvent.MOUSE_DOWN, fnComunidad);
			Comunidad_BT.addEventListener(MouseEvent.MOUSE_DOWN, fnBarrio_Comunidad);


			Ir_Pantalla_Trabajos_BT.addEventListener(MouseEvent.MOUSE_DOWN, fnTrabajos);
			trace(Cliente_var);
			// timer;
			_timer_trabajo.addEventListener(TimerEvent.TIMER, timerListenerTrabajos);
			_timer.addEventListener(TimerEvent.TIMER, timerListener);
		}

		function fnPlaca_Financiera(event:MouseEvent):void
		{
			Placa_financiera.visible = true;
		}

		function fnPlaca_Financiera_Cerrar(event:MouseEvent):void
		{
			Placa_financiera.visible = false;
		}

		function fnComunidad(event:MouseEvent):void
		{
			Barrio.visible = false;
		}

		function fnBarrio_Comunidad(event:MouseEvent):void
		{
			Barrio.visible = true;
		}


		//Timer general Todos los eventos determinados por el tiempo


		function timerListener(e:TimerEvent):void
		{
			var tiempost = _timer.currentCount;
			//trace(tiempost);
			Hora_var = _timer.currentCount;
			Horas.text = String(_timer.currentCount) + "  horas";
			Lista_Trabajos.Avance_laburo.text = String(Tiempo_total_arreglo);
			trace("avance laburo" + _timer_trabajo.currentCount);
			trace("tiempo  " + Tiempo_total_arreglo);
			//actualizar valores de la pantalla

			Dinero.text = String(Dinero_var);
			Comunidad.text = Comunidad_var;
			Placa_financiera.txt_total_capital.text = String(Dinero_var);
			Placa_financiera.txt_mes.text = String(Semana_var);
			Placa_financiera.txt_cuota.text = String(Cuota_Banco);
			Placa_financiera.txt_gastos_fijos.text = String(Gastos_Fijos);
			Placa_financiera.txt_gastos_personales.text = String(Gastos_Personales);
			Placa_financiera.txt_sueldos.text = String(Sueldos);
			Placa_financiera.txt_total_gastos.text = String(Sueldos + Gastos_Personales + Gastos_Fijos + Cuota_Banco);
			var Gastos = Sueldos + Gastos_Personales + Gastos_Fijos + Cuota_Banco;
			Placa_financiera.txt_saldo.text = String (Dinero_var - Gastos);










			// dia
			Hora_Dia_var = Hora_Dia_var + 1;
			if (Hora_Dia_var == Horas_para_Dia)
			{
				_timer.reset();
				// se resetea el timer del dia;
				_timer.start();
				fnCrear_Clientes();
				Dia_var = Dia_var + 1;
				Hora_Dia_var = 0;
				Dia.text = String(Dia_var);

				// semana
				Dia_Semana = Dia_Semana + 1;
				if (Dia_Semana == Dias_para_Semana)
				{
					Semana_var = Semana_var + 1;
					Dia_Semana = 0;
					Semana.text = String(Semana_var);
				}
			}
			//trace(Cliente_var.x);
			if (Cliente_var.x <= 110)
			{
				Cliente_var.visible = false;
				Cliente_var.gotoAndPlay("frente");
				Cliente_var.globito.gotoAndPlay("normal");
				Cliente_on_Stage = false;
			}
			if (_timer_espera_cliente.currentCount == 10)
			{
				Cliente_var.gotoAndPlay("espalda");
				Cliente_var.globito.gotoAndPlay("mal");
				_timer_espera_cliente.reset();
				_timer_espera_cliente.stop();
				var myPunkx:Tween = new Tween(Cliente_var,"x",None.easeInOut,Cliente_var.x,100,Velocidad_var,true);
				var myPunky:Tween = new Tween(Cliente_var,"y",None.easeInOut,Cliente_var.y,474,Velocidad_var,true);
			}


		}




		//Clientes
		// función random para la creacion del cliente

		function fnCrear_Clientes():void
		{
			//if (Hora_var == Horas_para_Dia)
			//{
			if (Cliente_on_Stage == false)
			{
				Nuevo_Cliente =((randomRange(0,5)));
				if (Viejo_Cliente == Nuevo_Cliente)
				{
					fnCrear_Clientes();// si se repite reinicia la función
				}
				_timer_espera_cliente.start();

				Cliente_on_Stage = true;
				fnCliente_Actual();
				trace("Cliente= " + Nuevo_Cliente);
			}
			//}
		}

		// selección de cliente
		function fnCliente_Actual():void
		{
			var Cliente_Texto =((randomRange(5,6)));// elige el texto del array
			var nombre_numero =((randomRange(0,4)));// elige el producto del array
			if (Producto_Viejo == nombre_numero)
			{
				fnCliente_Actual();
			}
			nombre = Elementos[nombre_numero];
			Producto_Viejo = nombre_numero;
			//trace(nombre);
			Viejo_Cliente = Nuevo_Cliente;
			switch (Nuevo_Cliente)
			{
				case 0 :
					Cliente_cara = Placa_Clientes.Mormon_MC;
					Placa_Clientes.Cliente_TXT.text = nombre[Cliente_Texto];
					Velocidad_var = 6;
					Cliente_var = Mormon;
					Nombre_Cliente = "Martín";
					Mover_cliente();
					fnTexto_Pedido();
					break;
				case 1 :
					Cliente_cara = Placa_Clientes.Vieja_MC;
					Placa_Clientes.Cliente_TXT.text = nombre[Cliente_Texto];
					Velocidad_var = 10;
					Cliente_var = Vieja;
					Nombre_Cliente = "Olga";
					Mover_cliente();
					fnTexto_Pedido();
					break;
				case 2 :
					//Placa_Clientes.Nena_MC.visible = true;
					Cliente_cara = Placa_Clientes.Nena_MC;
					Placa_Clientes.Cliente_TXT.text = nombre[Cliente_Texto];
					Velocidad_var = 4;
					Cliente_var = Nena;
					Nombre_Cliente = "Lucía";
					Mover_cliente();
					fnTexto_Pedido();
					break;
				case 3 :
					//Placa_Clientes.Coqueta_MC.visible = true;
					Cliente_cara = Placa_Clientes.Coqueta_MC;
					Placa_Clientes.Cliente_TXT.text = nombre[Cliente_Texto];
					Velocidad_var = 7;
					Cliente_var = Coqueta;
					Nombre_Cliente = "Andrea";
					Mover_cliente();
					fnTexto_Pedido();
					break;
				case 4 :
					//Placa_Clientes.Punk_MC.visible = true;
					Cliente_cara = Placa_Clientes.Punk_MC;
					Placa_Clientes.Cliente_TXT.text = nombre[Cliente_Texto];
					Velocidad_var = 6;
					Cliente_var = Punk;
					Nombre_Cliente = "Julio";

					Mover_cliente();
					fnTexto_Pedido();
					break;
				case 5 :
					//Placa_Clientes.Viejo_MC.visible = true;
					Cliente_cara = Placa_Clientes.Viejo_MC;
					Placa_Clientes.Cliente_TXT.text = nombre[Cliente_Texto];
					Velocidad_var = 10;
					Cliente_var = Viejo;
					Nombre_Cliente = "Gustavo";
					Mover_cliente();
					fnTexto_Pedido();
					break;
			}
		}


		function Mover_cliente():void
		{
			Cliente_var.visible = true;
			var Posicion_en_vertical =((randomRange(600,800)));
			var myPunkx:Tween = new Tween(Cliente_var,"x",None.easeInOut,200,600,Velocidad_var,true);
			var myPunky:Tween = new Tween(Cliente_var,"y",None.easeInOut,474,Posicion_en_vertical,Velocidad_var,true);
			Cliente_var.globito.addEventListener(MouseEvent.MOUSE_DOWN, fnPlaca_Cliente);
		}

		function fnPlaca_Cliente(event:MouseEvent):void
		{
			if (_timer_espera_cliente.currentCount != 0)
			{// si se está yendo no se habilita la placa
				Placa_Clientes.visible = true;
				Cliente_cara.visible = true;
				_timer_espera_cliente.stop();
				_timer_espera_cliente.reset();
			}

		}


		function fnTexto_Pedido():void
		{
			Placa_Clientes.Precio_TXT.text = "Precio  " + nombre[0];
			Placa_Clientes.Alfajias_TXT.text = nombre[1];
			Placa_Clientes.Tablones_TXT.text = nombre[2];
			Placa_Clientes.Tiempo_para_Hacer_TXT.text = nombre[3];
		}

		//boton de aceptar trabajo

		public function Clientes_Pedido(event:MouseEvent):void
		{
			nombre[8] = Nombre_Cliente;
			Trabajos.push(nombre);
			trace(Trabajos);
			Placa_Clientes.visible = false;
			Placa_Clientes.Mormon_MC.visible = false;
			Placa_Clientes.Nena_MC.visible = false;
			Placa_Clientes.Punk_MC.visible = false;
			Placa_Clientes.Vieja_MC.visible = false;
			Placa_Clientes.Viejo_MC.visible = false;
			Placa_Clientes.Coqueta_MC.visible = false;
			Cliente_var.gotoAndPlay("espalda");
			var myPunkx:Tween = new Tween(Cliente_var,"x",None.easeInOut,Cliente_var.x,100,Velocidad_var,true);
			var myPunky:Tween = new Tween(Cliente_var,"y",None.easeInOut,Cliente_var.y,474,Velocidad_var,true);
			//Tiempo_total_arreglo = nombre[3];


		}

		//Barraca
		public function En_Barraca(event:MouseEvent):void
		{
			Lista_Trabajos.visible = false;
			Barra.visible = true;
			Barra.Taladro_Pie.addEventListener(MouseEvent.MOUSE_DOWN, Comprar_Taladro_Pie);
			Barra.Caladora_Mano.addEventListener(MouseEvent.MOUSE_DOWN, Comprar_Caladora);
			Barra.Lata_Pintura.addEventListener(MouseEvent.MOUSE_DOWN, Comprar_Pintura);
			Barra.Cafetera_Chica.addEventListener(MouseEvent.MOUSE_DOWN, Comprar_Cafetera_Chica);
			Barra.Mesa_Combinada.addEventListener(MouseEvent.MOUSE_DOWN, Comprar_Mesa_Combinada);
			Barra.Sierra_Pie.addEventListener(MouseEvent.MOUSE_DOWN, Comprar_Sierra_Pie);
		}

		public function Comprar_Caladora(event:MouseEvent):void
		{
			cala_little.visible = true;
			Dinero_var = Dinero_var - Caladora_precio;
			Barra.visible = false;
			cala_little_var = 1;
		}

		public function Comprar_Sierra_Pie(event:MouseEvent):void
		{
			Caladora_de_Pie.visible = true;
			Dinero_var = Dinero_var - Caladora_Pie_precio;
			Barra.visible = false;
			cala_little_var = 1;
		}

		public function Comprar_Pintura(event:MouseEvent):void
		{
			Lata_Pintura_MC.visible = true;
			Dinero_var = Dinero_var - Pinturas_precio;
			Barra.visible = false;
			Pintura_var = 1;
		}

		public function Comprar_Cafetera_Chica(event:MouseEvent):void
		{
			Cafetera_Chica.visible = true;
			Dinero_var = Dinero_var - Cafetera_precio;
			Barra.visible = false;
			cala_big_var = 1;
		}

		public function Comprar_Mesa_Combinada(event:MouseEvent):void
		{
			Combinada_MC.visible = true;
			Dinero_var = Dinero_var - Mesa_Combinada_precio;
			Barra.visible = false;
			cala_big_var = 1;
		}

		public function Comprar_Taladro_Pie(event:MouseEvent):void
		{
			cala_big.visible = true;
			Dinero_var = Dinero_var - Taladro_Pie_precio;
			Barra.visible = false;
			cala_big_var = 1;
		}


		// Aserradero

		public function En_Madera(event:MouseEvent):void
		{
			Lista_Trabajos.visible = false;
			Madera_MC.visible = true;
			Madera_MC.Alfajias_Ingreso.text = "";
			Madera_MC.Tablones_Ingreso.text = "";
			Madera_MC.Resultado_Madera_BT.addEventListener(MouseEvent.MOUSE_DOWN, Resultado_Madera);
			Madera_MC.Resultado_Madera_BT2.addEventListener(MouseEvent.MOUSE_DOWN, Total_Madera);
		}

		public function Total_Madera(mc:MouseEvent):void
		{
			Alfajias_var_Numb = Number(Madera_MC.Alfajias_Ingreso.text);
			Tablones_var_Numb = Number(Madera_MC.Tablones_Ingreso.text);
			var Alfajias_var_compra = Alfajias_var_Numb * Alfajias_precio;
			var Tablones_var_compra = Tablones_var_Numb * Tablones_precio;

			//Resultado_Maderas_var = Alfajias_var_Numb + Tablones_var_Numb;
			//trace(Alfajias_var_compra + Tablones_var_compra);
			Dinero_var = Dinero_var - Alfajias_var_compra - Tablones_var_compra;
			Madera_MC.Total_TX.text = String(Alfajias_var_compra + Tablones_var_compra);
			//Madera_MC.visible = false;
		}

		public function Resultado_Madera(mc:MouseEvent):void
		{
			Alfajias_var_Numb = Number(Madera_MC.Alfajias_Ingreso.text);
			Tablones_var_Numb = Number(Madera_MC.Tablones_Ingreso.text);
			var Alfajias_var_compra = Alfajias_var_Numb * Alfajias_precio;
			var Tablones_var_compra = Tablones_var_Numb * Tablones_precio;
			//Resultado_Maderas_var = Alfajias_var_Numb + Tablones_var_Numb;
			//trace(Alfajias_var_compra + Tablones_var_compra);
			Dinero_var = Dinero_var - Alfajias_var_compra - Tablones_var_compra;
			Dinero.text = String(Dinero_var);
			Alfajias_Stock = Alfajias_Stock + Alfajias_var_Numb;
			Tablones_Stock = Tablones_Stock + Tablones_var_Numb;
			Madera_MC.visible = false;
		}


		// Trabajos


		function fnBotones_Trabajos(event:MouseEvent):void
		{
			trace(event.target.name, event.currentTarget.name);
			switch (event.target.name)
			{

				case "Array_Trabajos" :
					coso = Trabajos[0];
					Tiempo_total_arreglo = coso[3];
					Lista_Trabajos.Datos_Tiempo.text = String(Tiempo_total_arreglo);
					fnLista_Trabajos();
					break;
				case "Array_Trabajos1" :
					coso = Trabajos[1];
					Tiempo_total_arreglo = coso[3];
					fnLista_Trabajos();
					break;
				case "Array_Trabajos2" :
					coso = Trabajos[2];
					Tiempo_total_arreglo = coso[3];
					fnLista_Trabajos();
					break;
				case "Array_Trabajos3" :
					coso = Trabajos[3];
					Tiempo_total_arreglo = coso[3];
					fnLista_Trabajos();
					break;
				case "Array_Trabajos4" :
					coso = Trabajos[4];
					Tiempo_total_arreglo = coso[3];
					fnLista_Trabajos();
					break;

			}
		}

		function fnLista_Trabajos():void
		{
			Lista_Trabajos.Datos_Tiempo.text = String(Tiempo_total_arreglo);
			Lista_Trabajos.Datos_Precio.text = String(coso[0]);
			Lista_Trabajos.Datos_Trabajo.text = String(coso[4]);
			Lista_Trabajos.Datos_Materiales.text = "Tablones " + String(coso[1]) + "  Alfajías " + String(coso[2]);
			Lista_Trabajos.Datos_Cliente.text = String(coso[8]);
			Lista_Trabajos.Mormon_MC.visible = false;
			Lista_Trabajos.Vieja_MC.visible = false;
			Lista_Trabajos.Nena_MC.visible = false;
			Lista_Trabajos.Coqueta_MC.visible = false;
			Lista_Trabajos.Punk_MC.visible = false;
			Lista_Trabajos.Viejo_MC.visible = false;
			switch (coso[8])
			{
				case "Martín" :
					Lista_Trabajos.Mormon_MC.visible = true;
					break;
				case "Olga" :
					Lista_Trabajos.Vieja_MC.visible = true;
					break;
				case "Lucía" :
					Lista_Trabajos.Nena_MC.visible = true;
					break;
				case "Andrea" :
					Lista_Trabajos.Coqueta_MC.visible = true;
					break;
				case "Julio" :
					Lista_Trabajos.Punk_MC.visible = true;
					break;
				case "Gustavo" :
					Lista_Trabajos.Viejo_MC.visible = true;
					break;
			}

		}

		//Genera pantalla de lista de trabajos y carga los laburos en los diferentes casilleros

		public function fnTrabajos(event:MouseEvent):void
		{
			Lista_Trabajos.visible = true;
			Lista_Trabajos.Datos_Alfajias.text = String(Alfajias_Stock);
			Lista_Trabajos.Datos_Tablones.text = String(Tablones_Stock);

			Lista_Trabajos.Array_Trabajos.text = Trabajos[0];
			Lista_Trabajos.Array_Trabajos1.text = Trabajos[1];
			Lista_Trabajos.Array_Trabajos2.text = Trabajos[2];
			Lista_Trabajos.Array_Trabajos3.text = Trabajos[3];
			Lista_Trabajos.Array_Trabajos4.text = Trabajos[4];
		}

		// Se pone a hacer el trabajo

		public function fnEmpezarLaburo():void
		{
			if (Trabajo_en_Curso == false)
			{
				_timer_trabajo.start();
				//Lista_Trabajos.addChild(Empezar_Laburo_BT);
				//Empezar_Laburo_BT.x = -300;
				//Empezar_Laburo_BT.y = 0;
				Trabajo_en_Curso = true;// flag
				//Tiempo_total_arreglo = nombre [3];
				var myTween:Tween = new Tween(Lista_Trabajos.my_box,"x",None.easeInOut,40,300,Tiempo_total_arreglo,true);
			}
		}


		// se fija si laburo se termino

		function timerListenerTrabajos(e:TimerEvent):void
		{
			var _hora_trabajo = _timer_trabajo.currentCount;//variable local para comparar en el array
			if (_hora_trabajo == Tiempo_total_arreglo)
			{
				trace("laburo");// pa probar
				_timer_trabajo.stop();
				_timer_trabajo.reset();
				Trabajo_en_Curso = false;//flag
				Dinero_var = Silla[0] + Dinero_var;
				Tiempo_total_arreglo = 0;
				//Dinero.text = String(Dinero_var);
			}
		}

		public function fnCerrarLista(event:MouseEvent):void
		{
			Lista_Trabajos.visible = false;
		}

	}

}