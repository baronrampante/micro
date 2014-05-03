package 
{

	/* INDICE:
	 IMPORT
	 VARIABLES
	 INICIO
	 BARRACA
	 ASERRADERO
	 CLIENTES
	*/
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
		private var _tiempo_jugado:uint = 0;
		private var _tiempo_para_jugar:uint = 50;// definir el tiempo total aca


		public var cala_little_var = 0;
		public var cala_big_var = 0;
		public var Pintura_var = 0;

		//variables botones stage

		public var Dinero_var = 12000;
		public var Comunidad_var = 600;
		public var Dia_var = 0;
		public var Semana_var = 0;
		public var Hora_var = 1;
		public var Hora_Dia_var = 0;// se incrementa cada hora
		public var Horas_para_Dia = 3;// variable que determina el día
		public var Dias_para_Semana = 5;// variable que determina duracion semana
		public var Dia_Semana = 0;// variable que cuenta los dias para llegar a a la semana


		//variables compras

		var Alfajias_var_Numb:Number = 0;
		var Tablones_var_Numb:Number = 0;
		var Resultado_Maderas_var = 0;

		//precios

		var Alfajias_precio = 100;
		var Tablones_precio = 300;
		var Caladora_precio = 1000;
		var Taladro_banco_precio = 3000;
		var Cafetera_precio = 1500;

		//Clientes
		var Nuevo_Cliente = 0;

		// arrays clientes pedidos orden_= Precio, Alfajías, Tablones, Tiempo en horas, Cliente [4]
		var Eleccion_Trabajos:Array = new Array();
		var Silla:Array = new Array(500,1,1,8,0);
		var Cama:Array = new Array(1200,2,2,8,0);
		var Mesa:Array = new Array(1000,2,3,8,0);

		// array de trabajos
		var Trabajos:Array = new Array ();
		var Tiempo_construccion = 1000;

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
			Dinero.text = String(Dinero_var);
			Comunidad.text = String(Comunidad_var);
			Horas.text = String(_timer.currentCount) + "  horas";
			Semana.text = "Semana " + String(Semana_var);
			Dia.text = "Dia " + String(Dia_var);

			//clientes
			Placa_Clientes.Mormon_MC.visible = false;
			Placa_Clientes.Vieja_MC.visible = false;
			Placa_Clientes.Nena_MC.visible = false;
			Placa_Clientes.Coqueta_MC.visible = false;
			Placa_Clientes.Punk_MC.visible = false;
			Placa_Clientes.Viejo_MC.visible = false;


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

			//clientes creación
			fnClientes();

			//botones
			Placa_Clientes.Yes_BT.addEventListener(MouseEvent.MOUSE_DOWN, Clientes_Pedido);
			Ir_Barraca.addEventListener(MouseEvent.MOUSE_DOWN, En_Barraca);
			Ir_Madera.addEventListener(MouseEvent.MOUSE_DOWN, En_Madera);
			Lista_Trabajos.Cerrar_BT.addEventListener(MouseEvent.MOUSE_DOWN, fnCerrarLista);
			Lista_Trabajos.Aceptar1.addEventListener(MouseEvent.MOUSE_DOWN, fnAceptarLaburo);
			Ir_Pantalla_Trabajos_BT.addEventListener(MouseEvent.MOUSE_DOWN, fnTrabajos);

			// timer;
			_timer_trabajo.addEventListener(TimerEvent.TIMER, timerListenerTrabajos);
			_timer.addEventListener(TimerEvent.TIMER, timerListener);


			//Timer general Todos los eventos determinados por el tiempo

		}
		function timerListener(e:TimerEvent):void
		{
			var tiempost = _timer.currentCount;
			trace(tiempost);
			Hora_var = _timer.currentCount;
			Horas.text = String(_timer.currentCount) + "  horas";
			Lista_Trabajos.Avance_laburo.text = String(_timer_trabajo.currentCount);
			trace(_timer_trabajo.currentCount);
			// dia
			Hora_Dia_var = Hora_Dia_var + 1;
			if (Hora_Dia_var == Horas_para_Dia)
			{
				Dia_var = Dia_var + 1;
				Hora_Dia_var = 0;
				Dia.text = "Dia " + String(Dia_var);
				// semana
				Dia_Semana = Dia_Semana + 1;
				if (Dia_Semana == Dias_para_Semana)
				{
					Semana_var = Semana_var + 1;
					Dia_Semana = 0;
					Semana.text = "Semana " + String(Semana_var);
				}
			}
			fnClientes();
		}


		//Clientes
		// función random para la creacion del cliente

		function fnClientes():void
		{
			if (Hora_var == 10)
			{
				Nuevo_Cliente =((randomRange(1,5)));
				Placa_Clientes.visible = true;
				fnCliente_Actual();
				trace("Cliente= " + Nuevo_Cliente);
			}
		}
		
		// selección de cliente
		function fnCliente_Actual():void
		{
			switch (Nuevo_Cliente)
			{
				case 1:
				Placa_Clientes.Mormon_MC.visible = true;
				break;
				case 2:
				Placa_Clientes.Vieja_MC.visible = true;
				break;
				case 3:
				Placa_Clientes.Nena_MC.visible = true;
				break;
				case 4:
				Placa_Clientes.Coqueta_MC.visible = true;
				break;
				case 5:
				Placa_Clientes.Punk_MC.visible = false;
				break;
				case 6:
				Placa_Clientes.Viejo_MC.visible = false;
				break;
			}
		}


		public function Clientes_Pedido(event:MouseEvent):void
		{
			trace(Silla);
			var coso = Silla[0];
			trace(coso);
			Placa_Clientes.visible = false;
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
			Dinero.text = String(Dinero_var);
			Barra.visible = false;
			cala_little_var = 1;
		}

		public function Comprar_Sierra_Pie(event:MouseEvent):void
		{
			Caladora_de_Pie.visible = true;
			Barra.visible = false;
			cala_little_var = 1;
		}

		public function Comprar_Pintura(event:MouseEvent):void
		{
			Lata_Pintura_MC.visible = true;
			Barra.visible = false;
			Pintura_var = 1;
		}

		public function Comprar_Cafetera_Chica(event:MouseEvent):void
		{
			Cafetera_Chica.visible = true;
			Dinero_var = Dinero_var - Cafetera_precio;
			Dinero.text = String(Dinero_var);
			Barra.visible = false;
			cala_big_var = 1;
		}

		public function Comprar_Mesa_Combinada(event:MouseEvent):void
		{
			Combinada_MC.visible = true;
			Barra.visible = false;
			cala_big_var = 1;
		}

		public function Comprar_Taladro_Pie(event:MouseEvent):void
		{
			cala_big.visible = true;
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
			trace(Alfajias_var_compra + Tablones_var_compra);
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
			trace(Alfajias_var_compra + Tablones_var_compra);
			Dinero_var = Dinero_var - Alfajias_var_compra - Tablones_var_compra;
			Dinero.text = String(Dinero_var);
			Madera_MC.visible = false;
		}


		// Trabajos
		public function fnTrabajos(event:MouseEvent):void
		{
			Lista_Trabajos.visible = true;
		}

		public function fnAceptarLaburo(event:MouseEvent):void
		{
			Trabajos[1] = Silla[0];
			_timer_trabajo.start();
			Trabajo_en_Curso = true;// flag
			var myTween:Tween = new Tween(Lista_Trabajos.my_box,"x",None.easeInOut,40,300,Silla[3],true);
		}


		// se fija si laburo se termino

		function timerListenerTrabajos(e:TimerEvent):void
		{
			var _hora_trabajo = _timer_trabajo.currentCount;


			if (_hora_trabajo == Silla [3])
			{
				trace("laburo");// pa probar
				_timer_trabajo.stop();
				_timer_trabajo.reset();

				Trabajo_en_Curso = false;//flag
				Dinero_var = Silla[0] + Dinero_var;
				Dinero.text = String(Dinero_var);

			}
		}

		public function fnCerrarLista(event:MouseEvent):void
		{
			Lista_Trabajos.visible = false;
		}

	}

}