
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const SpeedNetApp());
}

const bg=Color(0xFF070012), card=Color(0xFF12051F), card2=Color(0xFF1E0B35), gold=Color(0xFFFFC857), purple=Color(0xFF7C3AED), blue=Color(0xFF8B5CF6), green=Color(0xFF22C55E);


final ValueNotifier<String> appLang = ValueNotifier<String>('English');

String tr(String key) {
  final lang = appLang.value;

  final en = {
    'home':'Home','special':'Special Offers','bundles':'Bundles','vas':'VAS','credit':'Credit Transfer','recharge':'Line Recharge','subs':'My Subscriptions','radio':'SpeedRadio','menu':'Menu','settings':'Settings','useful':'Useful Numbers','customer':'Customer Service','faqs':'FAQs','sms':'SMS','terms':'Terms & Privacy','about':'About Us','language':'Language','sound':'Sound','notifications':'Notifications','vibration':'Vibration','dark':'Dark Mode','call':'Call center','email':'Email','whatsapp':'WhatsApp','send_sms':'Send free SMS','send_req':'Send request','message':'Your message','topic':'Choose a topic','network':'Network support','quick':'Quick Actions','available':'Available','unavailable':'Unavailable','buy':'BUY BUNDLE','claim':'CLAIM / BUY OFFER','bundle_pages':'Bundle Pages','choose_package':'Choose a package below.','manual_payment':'Manual Payment','submit_payment':'SUBMIT PAYMENT','selected_package':'Selected Package','amount':'Amount','payment_id':'Payment ID / Transaction ID','upload_screenshot':'Upload Payment Screenshot','speednet_package_available':'SpeedNet package is available for activation','speednet_package_unavailable':'This package is unavailable/discontinued. QR generation blocked.','speednet_rdc':'SpeedNet RDC','digital':'Digital Self-Care • Congo & Angola','good':'SpeedNet RDC','get_started':'Get Started','login':'Login','phone':'Phone number','otp':'OTP Code','send_otp':'Send OTP','verify_otp':'Verify OTP','bundle_details':'Bundle Details','review_order':'REVIEW ORDER','price':'Price','validity':'Validity','package':'Package','network_lbl':'Network','auto_renew':'Auto Renew','payment_method':'Payment Method','speednet_mapping':'SpeedNet Mapping','service_page':'SpeedNet RDC premium service page.'
  };

  final fr = {
    'home':'Accueil','special':'Offres Spéciales','bundles':'Forfaits','vas':'VAS','credit':'Transfert de Crédit','recharge':'Recharge Ligne','subs':'Mes Abonnements','radio':'SpeedRadio','menu':'Menu','settings':'Paramètres','useful':'Numéros Utiles','customer':'Service Client','faqs':'FAQ','sms':'SMS','terms':'Conditions & Confidentialité','about':'À propos','language':'Langue','sound':'Son','notifications':'Notifications','vibration':'Vibration','dark':'Mode sombre','call':'Centre d’appel','email':'Email','whatsapp':'WhatsApp','send_sms':'Envoyer SMS gratuit','send_req':'Envoyer demande','message':'Votre message','topic':'Choisir un sujet','network':'Support réseau','quick':'Actions rapides','available':'Disponible','unavailable':'Indisponible','buy':'ACHETER LE FORFAIT','claim':'ACHETER L’OFFRE','bundle_pages':'Pages des forfaits','choose_package':'Choisissez un forfait ci-dessous.','manual_payment':'Paiement manuel','submit_payment':'SOUMETTRE LE PAIEMENT','selected_package':'Forfait sélectionné','amount':'Montant','payment_id':'ID de paiement / Transaction','upload_screenshot':'Télécharger la capture du paiement','speednet_package_available':'Le forfait SpeedNet est disponible pour activation','speednet_package_unavailable':'Ce forfait est indisponible/arrêté. QR bloqué.','speednet_rdc':'SpeedNet RDC','digital':'Self-care numérique • Congo & Angola','good':'SpeedNet RDC','get_started':'Commencer','login':'Connexion','phone':'Numéro de téléphone','otp':'Code OTP','send_otp':'Envoyer OTP','verify_otp':'Vérifier OTP','bundle_details':'Détails du forfait','review_order':'VÉRIFIER LA COMMANDE','price':'Prix','validity':'Validité','package':'Forfait','network_lbl':'Réseau','auto_renew':'Renouvellement auto','payment_method':'Méthode de paiement','speednet_mapping':'Mapping SpeedNet','service_page':'Page de service premium SpeedNet RDC.'
  };

  final pt = {
    'home':'Início','special':'Ofertas Especiais','bundles':'Pacotes','vas':'VAS','credit':'Transferência de Crédito','recharge':'Recarga de Linha','subs':'Minhas Subscrições','radio':'SpeedRadio','menu':'Menu','settings':'Configurações','useful':'Números Úteis','customer':'Atendimento ao Cliente','faqs':'FAQs','sms':'SMS','terms':'Termos & Privacidade','about':'Sobre nós','language':'Idioma','sound':'Som','notifications':'Notificações','vibration':'Vibração','dark':'Modo escuro','call':'Central de atendimento','email':'Email','whatsapp':'WhatsApp','send_sms':'Enviar SMS grátis','send_req':'Enviar pedido','message':'Sua mensagem','topic':'Escolha um tópico','network':'Suporte de rede','quick':'Ações rápidas','available':'Disponível','unavailable':'Indisponível','buy':'COMPRAR PACOTE','claim':'COMPRAR OFERTA','bundle_pages':'Páginas de pacotes','choose_package':'Escolha um pacote abaixo.','manual_payment':'Pagamento manual','submit_payment':'ENVIAR PAGAMENTO','selected_package':'Pacote selecionado','amount':'Valor','payment_id':'ID de pagamento / Transação','upload_screenshot':'Carregar comprovante de pagamento','speednet_package_available':'Pacote SpeedNet disponível para ativação','speednet_package_unavailable':'Este pacote está indisponível/descontinuado. QR bloqueado.','speednet_rdc':'SpeedNet RDC','digital':'Autoatendimento digital • Congo & Angola','good':'SpeedNet RDC','get_started':'Começar','login':'Login','phone':'Número de telefone','otp':'Código OTP','send_otp':'Enviar OTP','verify_otp':'Verificar OTP','bundle_details':'Detalhes do pacote','review_order':'REVISAR PEDIDO','price':'Preço','validity':'Validade','package':'Pacote','network_lbl':'Rede','auto_renew':'Renovação automática','payment_method':'Método de pagamento','speednet_mapping':'Mapeamento SpeedNet','service_page':'Página premium do serviço SpeedNet RDC.'
  };

  final ln = {
    'home':'Ebandeli','special':'Ba offres ya sipesiale','bundles':'Ba forfaits','vas':'VAS','credit':'Kotinda crédit','recharge':'Recharge ya ligne','subs':'Ba abonnements na ngai','radio':'SpeedRadio','menu':'Menu','settings':'Ba paramètres','useful':'Banumero ya tina','customer':'Lisungi ya client','faqs':'Mituna','sms':'SMS','terms':'Mibeko & Sekele','about':'Na tina na biso','language':'Lokota','sound':'Mongongo','notifications':'Mayebisi','vibration':'Vibration','dark':'Mode ya molili','call':'Centre d’appel','email':'Email','whatsapp':'WhatsApp','send_sms':'Tinda SMS ya ofele','send_req':'Tinda bosenga','message':'Message na yo','topic':'Pona likambo','network':'Lisungi ya réseau','quick':'Misala ya mbangu','available':'Ezali','unavailable':'Ezali te','buy':'SOMBA FORFAIT','claim':'SOMBA OFFRE','bundle_pages':'Ba page ya forfait','choose_package':'Pona forfait awa na se.','manual_payment':'Futeli ya maboko','submit_payment':'TINDA FUTELI','selected_package':'Forfait oponi','amount':'Motango','payment_id':'ID ya futeli / Transaction','upload_screenshot':'Tia elilingi ya futeli','speednet_package_available':'Forfait SpeedNet ezali mpo na activation','speednet_package_unavailable':'Forfait oyo ezali te. QR ekangami.','speednet_rdc':'SpeedNet RDC','digital':'Self-care numérique • Congo & Angola','good':'SpeedNet RDC','get_started':'Bandá','login':'Kokota','phone':'Nimero ya telefone','otp':'Code OTP','send_otp':'Tinda OTP','verify_otp':'Verifier OTP','bundle_details':'Makambo ya forfait','review_order':'TALA COMMANDE','price':'Prix','validity':'Validité','package':'Forfait','network_lbl':'Réseau','auto_renew':'Auto renouvellement','payment_method':'Lolenge ya kofuta','speednet_mapping':'Mapping SpeedNet','service_page':'Page premium ya service SpeedNet RDC.'
  };

  final data = lang == 'French' ? fr : lang == 'Portuguese' ? pt : lang == 'Lingala' ? ln : en;
  return data[key] ?? en[key] ?? key;
}

final Map<String, dynamic> bundleData = jsonDecode(r'''{"Internet": [["35 MB", "Validity: 3 Days", "500 Fc"], ["100 MB", "Validity: 3 Days", "1,000 Fc"], ["150 MB", "Validity: 3 Days", "1,300 Fc"]], "Special Bundles": [["100 MB", "Validity: 1 Hour", "1,000 Fc"], ["200 MB", "Validity: 2 Hours", "2,500 Fc"], ["5000 MB", "Validity: 00:00 \u2013 4:59 Hours", "7,000 Fc"]], "Voice": [["10 Min + 50 SMS + 1 GB", "Validity: 2 Days", "3,500 Fc"], ["1.65 Min + 20 MB + 20 SMS", "Validity: 1 Day", "500 Fc"], ["2.45 Min + 30 MB + 30 SMS", "Validity: 1 Day", "1,000 Fc"], ["3.3 Min + 40 MB + 40 SMS", "Validity: 1 Day", "1,500 Fc"], ["5 Min + 70 MB + 70 SMS", "Validity: 1 Day", "2,000 Fc"], ["8.25 Min + 120 MB + 120 SMS", "Validity: 1 Day", "2,500 Fc"], ["16.4 Min + 300 MB", "Validity: 3 Days", "6,000 Fc"], ["41 Min + 500 MB + 300 SMS", "Validity: 30 Days", "15,000 Fc"], ["164 Min + 3000 MB + 600 SMS", "Validity: 30 Days", "60,000 Fc"], ["820 Min + 14,000 MB + 1000 SMS", "Validity: 30 Days", "180,000 Fc"], ["1640 Min + 28,000 MB + 2000 SMS", "Validity: 3 Days", "360,000 Fc"]], "Neighbour Kitoko Packages": [["1.5 Min + 10 SMS + 10 MB", "Validity: 1 Day", "500 Fc"], ["3 Min + 30 SMS + 30 MB", "Validity: 1 Day", "1,000 Fc"], ["5 Min + 60 SMS + 60 MB", "Validity: 1 Day", "1,500 Fc"], ["8.2 Min + 120 SMS + 120 MB", "Validity: 1 Day", "2,000 Fc"], ["16.4 Min + 250 SMS + 250 MB", "Validity: 3 Days", "3,500 Fc"], ["20 Min + 275 SMS + 275 MB", "Validity: 5 Days", "7,000 Fc"], ["25 Min + 300 SMS + 300 MB", "Validity: 7 Days", "8,500 Fc"], ["50 Min + 500 SMS + 500 MB", "Validity: 7 Days", "12,000 Fc"], ["80 Min + 600 SMS + 600 MB", "Validity: 30 Days", "18,000 Fc"], ["160 Min + 7500 SMS + 2000 MB", "Validity: 30 Days", "25,000 Fc"], ["330 Min + 1000 SMS + 5000 MB", "Validity: 30 Days", "45,000 Fc"], ["820 Min + 1500 SMS + 18,000 MB", "Validity: 30 Days", "80,000 Fc"]], "SMS Packages": [["20 SMS", "Validity: 1 Day", "500 Fc"], ["70 SMS", "Validity: 1 Day", "1,000 Fc"], ["1000 SMS", "Validity: 1 Day", "6,000 Fc"], ["2000 SMS", "Validity: 1 Day", "10,000 Fc"], ["5000 SMS", "Validity: 1 Day", "15,000 Fc"]], "International Packages": [["10 GB", "Validity: 1 Day", "8,000 Fc"], ["25 GB", "Validity: 30 Days", "60,000 Fc"]], "Roaming Packages": [["100 MB", "Validity: 3 Days", "500 Fc"], ["500 MB", "Validity: 3 Days", "1,500 Fc"], ["1000 MB", "Validity: 7 Days", "3,500 Fc"], ["3000 MB", "Validity: 30 Days", "4,000 Fc"]], "Sunday Package": [["1000 MB", "Validity: 1 Day", "1,500 Fc"]], "Mega Boss Packages": [["7000 MB", "Validity: 15 Days", "11,000 Fc"], ["17,000 MB", "Validity: 30 Days", "32,000 Fc"], ["4000 MB", "Validity: 30 Days", "7,000 Fc"], ["8000 MB", "Validity: 30 Days", "15,000 Fc"], ["165,000 MB", "Validity: 30 Days", "320,000 Fc"], ["18,000 MB", "Validity: 30 Days", "33,000 Fc"], ["225,000 MB", "Validity: 30 Days", "440,000 Fc"], ["330,000 MB", "Validity: 30 Days", "640,000 Fc"]], "25 Years of Africa Packages": [["10 Min + 50 SMS + 1 GB", "Validity: 2 Days", "3,000 Fc"], ["250 MB + 25 SMS + 25 Night Min", "Validity: 3 Days", "2,500 Fc"], ["30 Min + 5 GB Night", "Validity: 3 Days", "4,000 Fc"], ["7000 MB", "Validity: 15 Days", "2,500 Fc"], ["25 Min + 25 GB Night", "Validity: 25 Days", "45,000 Fc"], ["17,000 MB", "Validity: 30 Days", "40,000 Fc"]]}''');
final List<dynamic> specialData = jsonDecode(r'''[["fc_500mb_3d", "500 MB", "Validity: 3 Days", "1000 FC"], ["fc_1gb_3d", "1 GB", "Validity: 3 Days", "2000 FC"], ["fc_2gb_3d", "2 GB", "Validity: 3 Days", "3000 FC"], ["fc_4gb_3d", "4 GB", "Validity: 3 Days", "6000 FC"], ["fc_12gb_10d", "12 GB", "Validity: 10 Days", "15000 FC"], ["sp_1000_1h", "1000MB", "1 hour", "1000 FC"], ["sp_2000_2h", "2000MB", "2 hours", "1500 FC"], ["sp_5000_night", "5000MB", "00H\u20134H59", "8000 FC"], ["sp_50_2d", "50MB", "2 days", "500 FC"], ["sp_300_2d", "300MB", "2 days", "1000 FC"], ["sp_1gb_2d", "1GB", "2 days", "1500 FC"], ["sp_1500_2d", "1500MB", "2 days", "2500 FC"], ["sp_2500_2d", "2500MB", "2 days", "3500 FC"], ["sp_3500_2d", "3500MB", "2 days", "5500 FC"], ["sp_180_3d", "180MB", "3 days", "500 FC"], ["sp_4500_3d", "4500MB", "3 days", "7500 FC"], ["sp_45000_30d", "45000MB", "30 days", "85000 FC"]]''');

class SpeedNetApp extends StatelessWidget {
  const SpeedNetApp({super.key});
  @override Widget build(BuildContext context)=>ValueListenableBuilder<String>(valueListenable: appLang, builder: (_, __, ___) => MaterialApp(
    debugShowCheckedModeBanner:false,
    title: tr('speednet_rdc'),
    theme:ThemeData(brightness:Brightness.dark, scaffoldBackgroundColor:bg, fontFamily:'Arial', colorScheme:ColorScheme.fromSeed(seedColor:purple, brightness:Brightness.dark), appBarTheme:const AppBarTheme(backgroundColor:bg,elevation:0,foregroundColor:Colors.white)),
    home: const SplashScreen()));
}


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController ac;
  late Animation<double> logoScale;
  late Animation<double> fade;

  @override
  void initState() {
    super.initState();
    ac = AnimationController(vsync: this, duration: const Duration(milliseconds: 2600))..forward();
    logoScale = Tween<double>(begin: .72, end: 1).animate(CurvedAnimation(parent: ac, curve: Curves.elasticOut));
    fade = CurvedAnimation(parent: ac, curve: Curves.easeIn);

    Timer(const Duration(seconds: 4), () {
      if (mounted) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const GetStartedScreen()));
      }
    });
  }

  @override
  void dispose() {
    ac.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: AnimatedBuilder(
      animation: ac,
      builder: (_, __) => Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.25,
            colors: [Color(0xFF3B0B68), Color(0xFF12001E), Colors.black],
          ),
        ),
        child: Stack(
          children: [
            Positioned.fill(child: CustomPaint(painter: SpeedNetSplashPainter(ac.value))),
            Center(
              child: FadeTransition(
                opacity: fade,
                child: ScaleTransition(
                  scale: logoScale,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: gold.withOpacity(.55), width: 1.6),
                          boxShadow: [
                            BoxShadow(color: purple.withOpacity(.60), blurRadius: 62, spreadRadius: 10),
                            BoxShadow(color: gold.withOpacity(.18), blurRadius: 88, spreadRadius: 6),
                          ],
                        ),
                        child: const AppLogo(size: 150),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'SPEEDNET RDC',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: 1.3,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        trText('Fast • Secure • Digital'),
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      const SizedBox(height: 76),
                      Text(trText('Powered by'), style: TextStyle(color: Colors.white70)),
                      const SizedBox(height: 8),
                      ShaderMask(
                        shaderCallback: (r) => const LinearGradient(
                          colors: [gold, Color(0xFFFFF0A8), purple],
                        ).createShader(r),
                        child: Text(
                          'SamyTech',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 26),
                      SizedBox(
                        width: 190,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: LinearProgressIndicator(
                            value: ac.value,
                            minHeight: 5,
                            color: gold,
                            backgroundColor: Colors.white12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class SpeedNetSplashPainter extends CustomPainter {
  final double t;
  SpeedNetSplashPainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);

    final purplePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..color = purple.withOpacity(.45);

    final goldPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..color = gold.withOpacity(.34);

    final bluePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = blue.withOpacity(.26);

    canvas.drawArc(
      Rect.fromCenter(center: center, width: size.width * .76, height: size.width * .76),
      t * 6.28,
      4.7,
      false,
      purplePaint,
    );

    canvas.drawArc(
      Rect.fromCenter(center: center, width: size.width * .55, height: size.width * .55),
      -t * 6.28,
      4.2,
      false,
      goldPaint,
    );

    canvas.drawArc(
      Rect.fromCenter(center: center, width: size.width * .95, height: size.width * .95),
      1.4 + t * 6.28,
      3.2,
      false,
      bluePaint,
    );

    final dotPaint = Paint()..color = gold.withOpacity(.65);
    for (int i = 0; i < 10; i++) {
      final dx = center.dx + (size.width * .38) * (i.isEven ? 1 : -1) * (0.35 + 0.05 * i);
      final dy = center.dy + ((i * 37 + t * 100) % 220) - 110;
      canvas.drawCircle(Offset(dx, dy), 2.5, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant SpeedNetSplashPainter oldDelegate) => true;
}

class AppLogo extends StatelessWidget{final double size; const AppLogo({super.key,this.size=80});@override Widget build(BuildContext context)=>Image.asset('assets/images/logo.png',height:size,fit:BoxFit.contain,errorBuilder:(_,__,___)=>Text('SPEEDNET',style:TextStyle(fontSize:size/4,fontWeight:FontWeight.w900,color:gold)));}


class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> with SingleTickerProviderStateMixin {
  late AnimationController ac;

  @override
  void initState() {
    super.initState();
    ac = AnimationController(vsync: this, duration: const Duration(seconds: 3))..repeat(reverse: true);
  }

  @override
  void dispose() {
    ac.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF16002C), Color(0xFF070012), Colors.black],
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 42),
          Row(
            children: [
              const AppLogo(size: 58),
              const SizedBox(width: 10),
              Text('SpeedNet RDC', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
              const Spacer(),
              TextButton(
                onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen())),
                child: Text(trText('Skip')),
              ),
            ],
          ),
          const SizedBox(height: 28),
          Expanded(
            child: AnimatedBuilder(
              animation: ac,
              builder: (_, __) => Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(36),
                  gradient: const LinearGradient(colors: [Color(0xFF2D1060), Color(0xFF0B0620)]),
                  border: Border.all(color: purple.withOpacity(.45)),
                  boxShadow: [
                    BoxShadow(color: purple.withOpacity(.25 + ac.value * .14), blurRadius: 40, offset: const Offset(0, 20)),
                  ],
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -26,
                      top: 55,
                      child: Transform.translate(
                        offset: Offset(0, -12 * ac.value),
                        child: Icon(Icons.rocket_launch, size: 185, color: purple.withOpacity(.25)),
                      ),
                    ),
                    Positioned(
                      left: 35,
                      right: 35,
                      bottom: 45,
                      child: Column(
                        children: [
                          Container(
                            height: 145,
                            width: 145,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: const LinearGradient(colors: [purple, blue]),
                              boxShadow: [BoxShadow(color: purple.withOpacity(.45), blurRadius: 40)],
                            ),
                            child: const Icon(Icons.rocket_launch, color: Colors.white, size: 80),
                          ),
                          const SizedBox(height: 30),
                          Text(
                            'Fast Internet\nFor Everyone',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 31, fontWeight: FontWeight.w900, height: 1.05),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Experience lightning fast digital self-care with SpeedNet.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white70, height: 1.4),
                          ),
                          const SizedBox(height: 22),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Dot(active: true),
                              Dot(active: false),
                              Dot(active: false),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          GlowPurpleButton(
            text: tr('get_started'),
            onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen())),
          ),
          const SizedBox(height: 12),
        ],
      ),
    ),
  );
}

class Dot extends StatelessWidget {
  final bool active;
  const Dot({super.key, required this.active});

  @override
  Widget build(BuildContext context) => AnimatedContainer(
    duration: const Duration(milliseconds: 250),
    margin: const EdgeInsets.symmetric(horizontal: 4),
    width: active ? 22 : 8,
    height: 8,
    decoration: BoxDecoration(
      color: active ? purple : Colors.white30,
      borderRadius: BorderRadius.circular(20),
    ),
  );
}

class LoginScreen extends StatefulWidget{const LoginScreen({super.key});@override State<LoginScreen> createState()=>_LoginScreenState();}
class _LoginScreenState extends State<LoginScreen>{
 final phone=TextEditingController(text:'+243900000000'), code=TextEditingController();
 String? vid; String msg=''; bool busy=false; String selectedCountry='Congo';

 final List<Map<String,String>> countries = const [
   {'name':'Congo','flag':'🇨🇩','code':'+243','hint':'+243 900 000 000'},
   {'name':'Angola','flag':'🇦🇴','code':'+244','hint':'+244 900 000 000'},
 ];

 Map<String,String> get currentCountry => countries.firstWhere((c)=>c['name']==selectedCountry,orElse:()=>countries.first);

 @override void dispose(){phone.dispose(); code.dispose(); super.dispose();}

 void selectCountry(String v){
   setState((){
     selectedCountry=v;
     final c=currentCountry['code']!;
     final raw=phone.text.trim();
     if(raw.isEmpty || raw.startsWith('+243') || raw.startsWith('+244')){
       phone.text='${c}900000000';
       phone.selection=TextSelection.collapsed(offset: phone.text.length);
     }
   });
 }

 Future<void> sendOtp() async {
   final number=phone.text.trim();
   if(number.isEmpty || !number.startsWith(currentCountry['code']!)){
     setState(()=>msg='${trText('Please enter a valid number for')} $selectedCountry ${currentCountry['code']}');
     return;
   }
   setState((){busy=true;msg=trText('Sending OTP...');});
   try{
     await FirebaseAuth.instance.verifyPhoneNumber(
       phoneNumber:number,
       timeout:const Duration(seconds:60),
       verificationCompleted:(c)async{await FirebaseAuth.instance.signInWithCredential(c); if(mounted) Navigator.pushReplacement(context,MaterialPageRoute(builder:(_)=>const MainShell()));},
       verificationFailed:(e)=>setState((){busy=false;msg='${trText('OTP failed')}: ${e.message??e.code}';}),
       codeSent:(v,_)=>setState((){vid=v;busy=false;msg=trText('OTP sent. Enter OTP code.');}),
       codeAutoRetrievalTimeout:(v)=>vid=v,
     );
   }catch(e){setState((){busy=false;msg='${trText('Error')}: $e';});}
 }

 Future<void> verify() async {
   if(vid==null){setState(()=>msg=trText('First press Send OTP'));return;}
   if(code.text.trim().isEmpty){setState(()=>msg=trText('Please enter OTP code'));return;}
   try{
     setState(()=>busy=true);
     final c=PhoneAuthProvider.credential(verificationId:vid!,smsCode:code.text.trim());
     await FirebaseAuth.instance.signInWithCredential(c);
     if(mounted) Navigator.pushReplacement(context,MaterialPageRoute(builder:(_)=>const MainShell()));
   }catch(e){setState((){busy=false;msg='${trText('Invalid OTP')}: $e';});}
 }

 Widget countryCard(Map<String,String> c){
   final selected=selectedCountry==c['name'];
   return Expanded(child:InkWell(
     borderRadius:BorderRadius.circular(20),
     onTap:()=>selectCountry(c['name']!),
     child:AnimatedContainer(
       duration:const Duration(milliseconds:220),
       padding:const EdgeInsets.symmetric(horizontal:10,vertical:13),
       decoration:BoxDecoration(
         borderRadius:BorderRadius.circular(20),
         gradient:selected?const LinearGradient(colors:[purple,blue]):null,
         color:selected?null:Colors.white.withOpacity(.06),
         border:Border.all(color:selected?gold:Colors.white24,width:selected?1.4:1),
         boxShadow:selected?[BoxShadow(color:purple.withOpacity(.30),blurRadius:20,offset:const Offset(0,8))]:[],
       ),
       child:Column(children:[
         Text(c['flag']!,style:const TextStyle(fontSize:25)),
         const SizedBox(height:6),
         Text(trText(c['name']!),style:TextStyle(fontWeight:FontWeight.w900,color:selected?Colors.white:Colors.white70)),
         const SizedBox(height:2),
         Text(c['code']!,style:TextStyle(fontSize:12,color:selected?gold:Colors.white54,fontWeight:FontWeight.w800)),
       ]),
     ),
   ));
 }


 Widget glowChip(IconData icon,String text){
   return Container(
     padding:const EdgeInsets.symmetric(horizontal:12,vertical:8),
     decoration:BoxDecoration(
       borderRadius:BorderRadius.circular(999),
       gradient:LinearGradient(colors:[Colors.white.withOpacity(.14),Colors.white.withOpacity(.05)]),
       border:Border.all(color:gold.withOpacity(.25)),
       boxShadow:[BoxShadow(color:purple.withOpacity(.18),blurRadius:18,offset:const Offset(0,8))],
     ),
     child:Row(mainAxisSize:MainAxisSize.min,children:[Icon(icon,color:gold,size:16),const SizedBox(width:7),Text(text,style:const TextStyle(color:Colors.white70,fontSize:12,fontWeight:FontWeight.w800))]),
   );
 }

 Widget miniFeature(IconData icon,String title,String sub){
   return Expanded(child:Container(
     padding:const EdgeInsets.all(10),
     decoration:BoxDecoration(
       color:Colors.white.withOpacity(.055),
       borderRadius:BorderRadius.circular(18),
       border:Border.all(color:Colors.white.withOpacity(.10)),
     ),
     child:Column(children:[
       Container(padding:const EdgeInsets.all(8),decoration:BoxDecoration(shape:BoxShape.circle,color:purple.withOpacity(.18),border:Border.all(color:gold.withOpacity(.20))),child:Icon(icon,color:gold,size:18)),
       const SizedBox(height:7),
       Text(title,textAlign:TextAlign.center,style:const TextStyle(fontWeight:FontWeight.w900,fontSize:11)),
       const SizedBox(height:2),
       Text(sub,textAlign:TextAlign.center,style:const TextStyle(color:Colors.white54,fontSize:10,height:1.2)),
     ]),
   ));
 }

 Widget premiumHero(){
   return Container(
     width:double.infinity,
     padding:const EdgeInsets.all(16),
     decoration:BoxDecoration(
       borderRadius:BorderRadius.circular(28),
       gradient:LinearGradient(begin:Alignment.topLeft,end:Alignment.bottomRight,colors:[purple.withOpacity(.55),const Color(0xFF17002D),blue.withOpacity(.24)]),
       border:Border.all(color:gold.withOpacity(.26)),
       boxShadow:[BoxShadow(color:purple.withOpacity(.30),blurRadius:32,offset:const Offset(0,14))],
     ),
     child:Stack(children:[
       Positioned(right:-35,top:-35,child:Container(width:120,height:120,decoration:BoxDecoration(shape:BoxShape.circle,color:gold.withOpacity(.08)))),
       Positioned(left:-25,bottom:-35,child:Container(width:130,height:130,decoration:BoxDecoration(shape:BoxShape.circle,color:blue.withOpacity(.13)))),
       Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
         Row(children:[
           Container(padding:const EdgeInsets.all(10),decoration:BoxDecoration(shape:BoxShape.circle,color:Colors.white.withOpacity(.13),border:Border.all(color:Colors.white24)),child:const Icon(Icons.rocket_launch,color:gold,size:20)),
           const SizedBox(width:10),
           Expanded(child:Text(trText('Premium digital self-care'),style:const TextStyle(fontSize:18,fontWeight:FontWeight.w900))),
           glowChip(Icons.security,trText('Secure')),
         ]),
         const SizedBox(height:10),
         Text(trText('Congo and Angola users can sign in with OTP and manage bundles, payments and eSIM orders from one SpeedNet account.'),style:const TextStyle(color:Colors.white70,fontSize:12,height:1.35)),
         const SizedBox(height:13),
         Wrap(spacing:8,runSpacing:8,children:[
           glowChip(Icons.public,'Congo • Angola'),
           glowChip(Icons.sim_card,'eSIM Ready'),
           glowChip(Icons.flash_on,'Fast OTP'),
         ]),
       ]),
     ]),
   );
 }

 @override Widget build(BuildContext context)=>ValueListenableBuilder<String>(
   valueListenable: appLang,
   builder:(context,lang,_)=>Shell(title: tr('login'),child:SingleChildScrollView(child:Column(children:[
     Row(mainAxisAlignment:MainAxisAlignment.end,children:[
       Container(
         padding:const EdgeInsets.symmetric(horizontal:10),
         decoration:BoxDecoration(color:Colors.white.withOpacity(.06),borderRadius:BorderRadius.circular(16),border:Border.all(color:Colors.white12)),
         child:DropdownButtonHideUnderline(child:DropdownButton<String>(
           value: lang,
           dropdownColor: const Color(0xFF12051F),
           iconEnabledColor: gold,
           items: [
             DropdownMenuItem(value:'English',child:Text(trText('English'))),
             DropdownMenuItem(value:'French',child:Text(trText('French'))),
             DropdownMenuItem(value:'Portuguese',child:Text(trText('Portuguese'))),
             DropdownMenuItem(value:'Lingala',child:Text(trText('Lingala'))),
           ],
           onChanged:(s){if(s!=null){appLang.value=s;}},
         )),
       ),
     ]),
     const SizedBox(height:18),
     Container(
       width:double.infinity,
       padding:const EdgeInsets.fromLTRB(18,22,18,18),
       decoration:BoxDecoration(
         borderRadius:BorderRadius.circular(32),
         gradient:LinearGradient(begin:Alignment.topLeft,end:Alignment.bottomRight,colors:[Colors.white.withOpacity(.10),Colors.white.withOpacity(.04)]),
         border:Border.all(color:gold.withOpacity(.32)),
         boxShadow:[BoxShadow(color:Colors.black.withOpacity(.30),blurRadius:26,offset:const Offset(0,12))],
       ),
       child:Column(children:[
         Container(
           padding:const EdgeInsets.all(12),
           decoration:BoxDecoration(shape:BoxShape.circle,gradient:const LinearGradient(colors:[purple,blue]),boxShadow:[BoxShadow(color:purple.withOpacity(.40),blurRadius:28)]),
           child:const AppLogo(size:72),
         ),
         const SizedBox(height:14),
         Text(trText('Welcome to SpeedNet RDC'),textAlign:TextAlign.center,style:const TextStyle(fontSize:26,fontWeight:FontWeight.w900)),
         const SizedBox(height:6),
         Text(trText('Select Congo or Angola and sign in with your mobile number'),textAlign:TextAlign.center,style:const TextStyle(color:Colors.white70,fontSize:13,height:1.35)),
         const SizedBox(height:14),
         premiumHero(),
         const SizedBox(height:14),
         Row(children:[
           miniFeature(Icons.speed,trText('Fast'),trText('OTP login')),
           const SizedBox(width:8),
           miniFeature(Icons.public,trText('Coverage'),trText('Congo & Angola')),
           const SizedBox(width:8),
           miniFeature(Icons.support_agent,trText('Support'),trText('24/7 help')),
         ]),
         const SizedBox(height:20),
         Align(alignment:Alignment.centerLeft,child:Text(trText('Choose your country'),style:const TextStyle(fontWeight:FontWeight.w900,color:Colors.white70))),
         const SizedBox(height:10),
         Row(children:[countryCard(countries[0]),const SizedBox(width:10),countryCard(countries[1])]),
         const SizedBox(height:18),
         Align(alignment:Alignment.centerLeft,child:Text('${trText('Selected country')}: ${currentCountry['flag']} ${trText(selectedCountry)}',style:const TextStyle(color:gold,fontWeight:FontWeight.w900))),
         const SizedBox(height:10),
         Container(width:double.infinity,padding:const EdgeInsets.all(12),decoration:BoxDecoration(gradient:LinearGradient(colors:[purple.withOpacity(.18),gold.withOpacity(.08)]),borderRadius:BorderRadius.circular(18),border:Border.all(color:gold.withOpacity(.24))),child:Row(children:[Container(padding:const EdgeInsets.all(9),decoration:BoxDecoration(shape:BoxShape.circle,color:gold.withOpacity(.16)),child:const Icon(Icons.verified_user,color:gold,size:18)),const SizedBox(width:10),Expanded(child:Text(trText('Secure OTP verification for your SpeedNet account'),style:const TextStyle(color:Colors.white70,fontWeight:FontWeight.w800,fontSize:12,height:1.25)))])),
         const SizedBox(height:12),
         TextField(
           controller:phone,
           keyboardType:TextInputType.phone,
           style:const TextStyle(fontWeight:FontWeight.w800),
           decoration:InputDecoration(
             prefixIcon:const Icon(Icons.phone_android,color:gold),
             labelText:'${tr('phone')} (${currentCountry['code']})',
             hintText:currentCountry['hint'],
             filled:true,
             fillColor:Colors.black.withOpacity(.22),
             border:OutlineInputBorder(borderRadius:BorderRadius.circular(20),borderSide:BorderSide.none),
             enabledBorder:OutlineInputBorder(borderRadius:BorderRadius.circular(20),borderSide:BorderSide(color:Colors.white.withOpacity(.10))),
             focusedBorder:OutlineInputBorder(borderRadius:BorderRadius.circular(20),borderSide:const BorderSide(color:gold,width:1.3)),
           ),
         ),
         const SizedBox(height:12),
         GoldButton(text:busy?trText('Please wait...'):tr('send_otp'),onTap:busy?(){}:sendOtp),
         const SizedBox(height:15),
         TextField(
           controller:code,
           keyboardType:TextInputType.number,
           style:const TextStyle(fontWeight:FontWeight.w800,letterSpacing:2),
           decoration:InputDecoration(
             prefixIcon:const Icon(Icons.lock_outline,color:gold),
             labelText:tr('otp'),
             hintText:'000000',
             filled:true,
             fillColor:Colors.black.withOpacity(.22),
             border:OutlineInputBorder(borderRadius:BorderRadius.circular(20),borderSide:BorderSide.none),
             enabledBorder:OutlineInputBorder(borderRadius:BorderRadius.circular(20),borderSide:BorderSide(color:Colors.white.withOpacity(.10))),
             focusedBorder:OutlineInputBorder(borderRadius:BorderRadius.circular(20),borderSide:const BorderSide(color:gold,width:1.3)),
           ),
         ),
         const SizedBox(height:12),
         GoldButton(text:tr('verify_otp'),onTap:verify),
         const SizedBox(height:16),
         if(msg.isNotEmpty) Container(width:double.infinity,padding:const EdgeInsets.all(12),decoration:BoxDecoration(color:Colors.white.withOpacity(.06),borderRadius:BorderRadius.circular(16),border:Border.all(color:Colors.white12)),child:Text(msg,textAlign:TextAlign.center,style:const TextStyle(color:Colors.white70,fontSize:12))),
       ]),
     ),
   ]))),
 );
}

class MainShell extends StatefulWidget{const MainShell({super.key});@override State<MainShell> createState()=>_MainShellState();}
class _MainShellState extends State<MainShell>{
  int i=0;
  @override Widget build(BuildContext context)=>ValueListenableBuilder<String>(
    valueListenable: appLang,
    builder: (_, lang, __) {
      final pages=<Widget>[
        HomePage(key: ValueKey('home-$lang')),
        SpecialOffersPage(key: ValueKey('special-$lang')),
        BundlesPage(key: ValueKey('bundles-$lang')),
        MySubscriptionsPage(key: ValueKey('subs-$lang')),
        MenuPage(key: ValueKey('menu-$lang')),
      ];
      return Scaffold(
        body: pages[i],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex:i,
          onTap:(v)=>setState(()=>i=v),
          type:BottomNavigationBarType.fixed,
          backgroundColor:const Color(0xFF0D0618),
          selectedItemColor:gold,
          unselectedItemColor:Colors.white60,
          items:[
            BottomNavigationBarItem(icon:const Icon(Icons.home),label: tr('home')),
            BottomNavigationBarItem(icon:const Icon(Icons.local_offer),label: tr('special')),
            BottomNavigationBarItem(icon:const Icon(Icons.inventory_2),label: tr('bundles')),
            BottomNavigationBarItem(icon:const Icon(Icons.sim_card),label: tr('subs')),
            BottomNavigationBarItem(icon:const Icon(Icons.menu),label: tr('menu')),
          ],
        ),
      );
    },
  );
}



class HomeLanguageSelector extends StatelessWidget {
  HomeLanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: appLang,
      builder: (_, lang, __) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: card2.withOpacity(.95),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: gold.withOpacity(.35)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: lang,
              dropdownColor: card2,
              iconEnabledColor: gold,
              style: const TextStyle(color: Colors.white, fontSize: 12),
              items: [
                DropdownMenuItem(value: 'English', child: Text(trText('English'))),
                DropdownMenuItem(value: 'French', child: Text(trText('French'))),
                DropdownMenuItem(value: 'Portuguese', child: Text(trText('Portuguese'))),
                DropdownMenuItem(value: 'Lingala', child: Text(trText('Lingala'))),
              ],
              onChanged: (v) {
                if (v != null) appLang.value = v;
              },
            ),
          ),
        );
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => Shell(
    title: 'SpeedNet RDC',
    back: false,
    titleWidget: Row(
      children: [
        
        const AppLogo(size: 42),
        const SizedBox(width: 8),
        Text(tr('speednet_rdc'), style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 20)),
        const Spacer(),
        HomeLanguageSelector(),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        const HeroCarousel(),
        const SizedBox(height: 18),
        Text(tr('quick'), style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 14,
          crossAxisSpacing: 14,
          childAspectRatio: .93,
          children: [
            ModernHomeTile(icon: Icons.local_offer, label: tr('special'), onTap: () => push(context, const SpecialOffersPage())),
            ModernHomeTile(icon: Icons.inventory_2, label: tr('bundles'), onTap: () => push(context, const BundlesPage())),
            ModernHomeTile(icon: Icons.widgets, label: tr('vas'), onTap: () => push(context, const VasPage())),
            ModernHomeTile(icon: Icons.radio, label: tr('radio'), onTap: () => push(context, const SpeedRadioPage())),
            ModernHomeTile(icon: Icons.sim_card, label: tr('subs'), onTap: () => push(context, const MySubscriptionsPage())),
            ModernHomeTile(icon: Icons.phone_android, label: tr('recharge'), onTap: () => push(context, const RechargePage())),
            ModernHomeTile(icon: Icons.swap_horiz, label: tr('credit'), onTap: () => push(context, const CreditTransferPage())),
          ],
        ),
        const SizedBox(height: 22),
        Header('Special Offers', () => push(context, const SpecialOffersPage())),
        SizedBox(
          height: 168,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: specialData.take(5).map((o) => OfferMini(o: o)).toList(),
          ),
        ),
      ],
    ),
  );
}

class ModernGreetingCard extends StatelessWidget {
  const ModernGreetingCard({super.key});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(26),
      gradient: const LinearGradient(colors: [Color(0xFF2C1062), Color(0xFF12051F)]),
      border: Border.all(color: purple.withOpacity(.35)),
      boxShadow: [BoxShadow(color: purple.withOpacity(.18), blurRadius: 28, offset: const Offset(0, 14))],
    ),
    child: Row(
      children: [
        Container(
          height: 52,
          width: 52,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(colors: [purple, blue]),
            boxShadow: [BoxShadow(color: purple.withOpacity(.40), blurRadius: 20)],
          ),
          child: const Icon(Icons.wifi, color: Colors.white, size: 30),
        ),
        const SizedBox(width: 14),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('SpeedNet RDC', style: TextStyle(color: Colors.white70)),
              SizedBox(height: 4),
              Text('SpeedNet User', style: TextStyle(fontSize: 21, fontWeight: FontWeight.w900)),
            ],
          ),
        ),
        const Icon(Icons.notifications_none, color: gold),
      ],
    ),
  );
}

class ModernHomeTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const ModernHomeTile({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: card2.withOpacity(.90),
        border: Border.all(color: Colors.white.withOpacity(.08)),
        boxShadow: [BoxShadow(color: purple.withOpacity(.12), blurRadius: 18, offset: const Offset(0, 9))],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(colors: [purple, blue]),
            ),
            child: Icon(icon, color: Colors.white, size: 25),
          ),
          const SizedBox(height: 10),
          Text(label, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 12)),
        ],
      ),
    ),
  );
}

class HeroCarousel extends StatefulWidget{const HeroCarousel({super.key});@override State<HeroCarousel> createState()=>_HeroCarouselState();}
class _HeroCarouselState extends State<HeroCarousel>{final pc=PageController(viewportFraction:.92);int idx=0;Timer? timer;final imgs=['banner1.png','banner2.png','banner3.png','banner4.png'];@override void initState(){super.initState();timer=Timer.periodic(const Duration(seconds:4),(_){if(pc.hasClients)pc.animateToPage((idx+1)%imgs.length,duration:const Duration(milliseconds:700),curve:Curves.easeOutCubic);});}@override void dispose(){timer?.cancel();pc.dispose();super.dispose();}@override Widget build(BuildContext context)=>Column(children:[
SizedBox(height:205,child:PageView.builder(controller:pc,itemCount:imgs.length,onPageChanged:(v)=>setState(()=>idx=v),itemBuilder:(_,x)=>AnimatedContainer(duration:const Duration(milliseconds:500),margin:EdgeInsets.fromLTRB(5,8,5,idx==x?8:20),child:BannerBox(image:imgs[x]))),),Row(mainAxisAlignment:MainAxisAlignment.center,children:List.generate(imgs.length,(x)=>AnimatedContainer(duration:const Duration(milliseconds:250),margin:const EdgeInsets.all(3),width:idx==x?18:7,height:7,decoration:BoxDecoration(color:idx==x?gold:Colors.white38,borderRadius:BorderRadius.circular(12))))),const SizedBox(height:14)]);}





String trText(String text) {
  final lang = appLang.value;
  if (lang == 'English') return text;

  String norm(String v) => v.toLowerCase().trim().replaceAll(RegExp(r'\s+'), ' ');

  final fr = <String, String>{
    'Fast • Secure • Digital': 'Rapide • Sécurisé • Digital',
    'Powered by': 'Propulsé par',
    'Secure one-time OTP login': 'Connexion OTP sécurisée une seule fois',
    'Welcome to SpeedNet RDC': 'Bienvenue sur SpeedNet RDC',
    'Select Congo or Angola and sign in with your mobile number': 'Sélectionnez Congo ou Angola et connectez-vous avec votre numéro mobile',
    'Choose your country': 'Choisissez votre pays',
    'Secure OTP verification for your SpeedNet account': 'Vérification OTP sécurisée pour votre compte SpeedNet',
    'Congo': 'Congo',
    'Angola': 'Angola',
    'Fast': 'Rapide',
    'Coverage': 'Couverture',
    'Support': 'Support',
    'OTP login': 'Connexion OTP',
    '24/7 help': 'Aide 24/7',
    'Premium digital self-care': 'Self-care digital premium',
    'Secure': 'Sécurisé',
    'Congo and Angola users can sign in with OTP and manage bundles, payments and eSIM orders from one SpeedNet account.': 'Les utilisateurs du Congo et d’Angola peuvent se connecter avec OTP et gérer forfaits, paiements et commandes eSIM depuis un seul compte SpeedNet.',
    'eSIM Ready': 'eSIM prêt',
    'Fast OTP': 'OTP rapide',
    'Selected country': 'Pays sélectionné',
    'Please wait...': 'Veuillez patienter...',
    'Sending OTP...': 'Envoi OTP...',
    'OTP sent. Enter OTP code.': 'OTP envoyé. Entrez le code OTP.',
    'First press Send OTP': 'Appuyez d’abord sur Envoyer OTP',
    'Please enter OTP code': 'Veuillez entrer le code OTP',
    'Invalid OTP': 'OTP invalide',
    'OTP failed': 'Échec OTP',
    'Error': 'Erreur',
    'Please enter a valid number for': 'Veuillez entrer un numéro valide pour',
    'All original web bundle pages in premium mobile column layout.': 'Toutes les pages forfaits du site en mise en page mobile premium.',
    'Bundle Pages': 'Pages des forfaits',
    'packages available': 'forfaits disponibles',
    'Choose a package below.': 'Choisissez un forfait ci-dessous.',
    'SpeedNet packages from your original web project.': 'Forfaits SpeedNet de votre projet web original.',
    'SpeedNet package is available for activation': 'Le forfait SpeedNet est disponible pour activation',
    'This package is unavailable/discontinued. QR generation blocked.': 'Ce forfait est indisponible/arrêté. Génération QR bloquée.',
    'Original web offers with premium black-purple-gold design.': 'Offres web originales avec design premium noir-violet-or.',
    'Offer ID:': 'ID de l’offre :',
    'SpeedNet Bundle': 'Forfait SpeedNet',
    'Choose Payment Provider': 'Choisir le fournisseur de paiement',
    'Manual Payment': 'Paiement manuel',
    'Choose wallet, enter payment ID and upload screenshot.': 'Choisissez le portefeuille, entrez l’ID de paiement et téléchargez la capture.',
    'Send payment to:': 'Envoyez le paiement à :',
    'Upload Payment Screenshot': 'Télécharger la capture du paiement',
    'Please enter Payment ID and upload screenshot.': 'Veuillez saisir l’ID de paiement et téléverser la capture.',
    'Payment submitted via': 'Paiement soumis via',
    'for admin approval.': 'pour validation admin.',
    'SpeedNet call center & key contacts.': 'Centre d’appel SpeedNet et contacts clés.',
    'Web demo of your free SMS screen.': 'Démo web de votre écran SMS gratuit.',
    'SpeedNet RDC service policy.': 'Politique de service SpeedNet RDC.',
    'SpeedNet RDC premium service page.': 'Page de service premium SpeedNet RDC.',
    'View all': 'Voir tout',
    'Skip': 'Passer',
    'OPEN': 'OUVERT',
    'Bundle Details': 'Détails du forfait',
    'Airtel Money': 'Airtel Money',
    'Orange Money': 'Orange Money',
    'Unitel Money': 'Unitel Money',
    'English': 'Anglais', 'French': 'Français', 'Portuguese': 'Portugais', 'Lingala': 'Lingala',
    'No': 'Non',
    'Backend preserved': 'Backend conservé',
    'Manual Approval': 'Validation manuelle',
    'Admin will verify payment': 'L’admin vérifiera le paiement',
    'Wallet Number': 'Numéro wallet',
    'Account Name': 'Nom du compte',
    'Enter payment reference': 'Entrez la référence du paiement',
    'Tap to select screenshot image': 'Appuyez pour sélectionner la capture',
    'Note / WhatsApp Number': 'Note / Numéro WhatsApp',
    'Optional note for admin': 'Note optionnelle pour admin',
    'Internet': 'Internet',
    'Special Bundles': 'Forfaits spéciaux',
    'Voice': 'Voix',
    'Neighbour Kitoko Packages': 'Forfaits Neighbour Kitoko',
    'SMS Packages': 'Forfaits SMS',
    'International Packages': 'Forfaits internationaux',
    'Roaming Packages': 'Forfaits roaming',
    'Sunday Package': 'Forfait dimanche',
    'Mega Boss Packages': 'Forfaits Mega Boss',
    '25 Years of Africa Packages': 'Forfaits 25 ans d’Afrique',
    'How to buy bundles?': 'Comment acheter des forfaits ?',
    'Open Bundles, choose package, press Buy and submit manual payment.': 'Ouvrez Forfaits, choisissez un forfait, appuyez Acheter et soumettez le paiement manuel.',
    'How eSIM QR comes?': 'Comment arrive le QR eSIM ?',
    'After admin approval backend calls SpeedNet mapped package and generates QR.': 'Après validation admin, le backend appelle le forfait SpeedNet mappé et génère le QR.',
    'Which payment method?': 'Quelle méthode de paiement ?',
    'Manual payment through Airtel Money / Unitel Money.': 'Paiement manuel via Airtel Money / Unitel Money.',
    'SpeedNet Digital Self-Care for Congo & Angola.': 'Self-care digital SpeedNet pour Congo & Angola.',
    'Value Added Services from the uploaded SpeedNet web project.': 'Services à valeur ajoutée du projet web SpeedNet téléchargé.',
    'Transfer credit/share data services.': 'Services de transfert de crédit/partage de données.',
    'Line Recharge with manual payment method.': 'Recharge ligne avec paiement manuel.',
    'Your eSIMs, active bundles and order status.': 'Vos eSIMs, forfaits actifs et statut des commandes.',
    'SpeedRadio page from the web project.': 'Page SpeedRadio du projet web.',
  };
  final pt = <String, String>{
    'Fast • Secure • Digital': 'Rápido • Seguro • Digital',
    'Powered by': 'Desenvolvido por',
    'Secure one-time OTP login': 'Login OTP seguro uma única vez',
    'Welcome to SpeedNet RDC': 'Bem-vindo ao SpeedNet RDC',
    'Select Congo or Angola and sign in with your mobile number': 'Selecione Congo ou Angola e entre com seu número de celular',
    'Choose your country': 'Escolha seu país',
    'Secure OTP verification for your SpeedNet account': 'Verificação OTP segura para sua conta SpeedNet',
    'Congo': 'Congo',
    'Angola': 'Angola',
    'Fast': 'Rápido',
    'Coverage': 'Cobertura',
    'Support': 'Suporte',
    'OTP login': 'Login OTP',
    '24/7 help': 'Ajuda 24/7',
    'Premium digital self-care': 'Autoatendimento digital premium',
    'Secure': 'Seguro',
    'Congo and Angola users can sign in with OTP and manage bundles, payments and eSIM orders from one SpeedNet account.': 'Usuários do Congo e Angola podem entrar com OTP e gerenciar pacotes, pagamentos e pedidos eSIM em uma conta SpeedNet.',
    'eSIM Ready': 'eSIM pronto',
    'Fast OTP': 'OTP rápido',
    'Selected country': 'País selecionado',
    'Please wait...': 'Aguarde...',
    'Sending OTP...': 'Enviando OTP...',
    'OTP sent. Enter OTP code.': 'OTP enviado. Digite o código OTP.',
    'First press Send OTP': 'Primeiro pressione Enviar OTP',
    'Please enter OTP code': 'Digite o código OTP',
    'Invalid OTP': 'OTP inválido',
    'OTP failed': 'Falha no OTP',
    'Error': 'Erro',
    'Please enter a valid number for': 'Digite um número válido para',
    'All original web bundle pages in premium mobile column layout.': 'Todas as páginas de pacotes do site em layout mobile premium.',
    'Bundle Pages': 'Páginas de pacotes',
    'packages available': 'pacotes disponíveis',
    'Choose a package below.': 'Escolha um pacote abaixo.',
    'SpeedNet packages from your original web project.': 'Pacotes SpeedNet do seu projeto web original.',
    'SpeedNet package is available for activation': 'Pacote SpeedNet disponível para ativação',
    'This package is unavailable/discontinued. QR generation blocked.': 'Este pacote está indisponível/descontinuado. QR bloqueado.',
    'Original web offers with premium black-purple-gold design.': 'Ofertas web originais com design premium preto-roxo-dourado.',
    'Offer ID:': 'ID da oferta:',
    'SpeedNet Bundle': 'Pacote SpeedNet',
    'Choose Payment Provider': 'Escolher provedor de pagamento',
    'Manual Payment': 'Pagamento manual',
    'Choose wallet, enter payment ID and upload screenshot.': 'Escolha a carteira, insira o ID de pagamento e envie a captura.',
    'Send payment to:': 'Enviar pagamento para:',
    'Upload Payment Screenshot': 'Carregar comprovante de pagamento',
    'Please enter Payment ID and upload screenshot.': 'Insira o ID de pagamento e carregue a captura.',
    'Payment submitted via': 'Pagamento enviado via',
    'for admin approval.': 'para aprovação do admin.',
    'SpeedNet call center & key contacts.': 'Central SpeedNet e contatos principais.',
    'Web demo of your free SMS screen.': 'Demonstração web da sua tela SMS grátis.',
    'SpeedNet RDC service policy.': 'Política de serviço SpeedNet RDC.',
    'SpeedNet RDC premium service page.': 'Página premium de serviço SpeedNet RDC.',
    'View all': 'Ver tudo',
    'Skip': 'Pular',
    'OPEN': 'ABERTO',
    'Bundle Details': 'Detalhes do pacote',
    'Airtel Money': 'Airtel Money',
    'Orange Money': 'Orange Money',
    'Unitel Money': 'Unitel Money',
    'English': 'Inglês', 'French': 'Francês', 'Portuguese': 'Português', 'Lingala': 'Lingala',
    'No': 'Não',
    'Backend preserved': 'Backend preservado',
    'Manual Approval': 'Aprovação manual',
    'Admin will verify payment': 'O admin verificará o pagamento',
    'Wallet Number': 'Número da carteira',
    'Account Name': 'Nome da conta',
    'Enter payment reference': 'Digite a referência do pagamento',
    'Tap to select screenshot image': 'Toque para selecionar a captura',
    'Note / WhatsApp Number': 'Nota / Número WhatsApp',
    'Optional note for admin': 'Nota opcional para admin',
    'Internet': 'Internet',
    'Special Bundles': 'Pacotes especiais',
    'Voice': 'Voz',
    'Neighbour Kitoko Packages': 'Pacotes Neighbour Kitoko',
    'SMS Packages': 'Pacotes SMS',
    'International Packages': 'Pacotes internacionais',
    'Roaming Packages': 'Pacotes roaming',
    'Sunday Package': 'Pacote de domingo',
    'Mega Boss Packages': 'Pacotes Mega Boss',
    '25 Years of Africa Packages': 'Pacotes 25 anos de África',
    'How to buy bundles?': 'Como comprar pacotes?',
    'Open Bundles, choose package, press Buy and submit manual payment.': 'Abra Pacotes, escolha o pacote, pressione Comprar e envie o pagamento manual.',
    'How eSIM QR comes?': 'Como chega o QR eSIM?',
    'After admin approval backend calls SpeedNet mapped package and generates QR.': 'Após aprovação do admin, o backend chama o pacote SpeedNet mapeado e gera o QR.',
    'Which payment method?': 'Qual método de pagamento?',
    'Manual payment through Airtel Money / Unitel Money.': 'Pagamento manual por Airtel Money / Unitel Money.',
    'SpeedNet Digital Self-Care for Congo & Angola.': 'Autoatendimento digital SpeedNet para Congo & Angola.',
    'Value Added Services from the uploaded SpeedNet web project.': 'Serviços de valor agregado do projeto web SpeedNet enviado.',
    'Transfer credit/share data services.': 'Serviços de transferência de crédito/partilha de dados.',
    'Line Recharge with manual payment method.': 'Recarga de linha com pagamento manual.',
    'Your eSIMs, active bundles and order status.': 'Seus eSIMs, pacotes ativos e status do pedido.',
    'SpeedRadio page from the web project.': 'Página SpeedRadio do projeto web.',
  };
  final ln = <String, String>{
    'Fast • Secure • Digital': 'Mbangu • Ya sekele • Digital',
    'Powered by': 'Esalemi na',
    'Secure one-time OTP login': 'Kokota na OTP ya sekele mbala moko',
    'Welcome to SpeedNet RDC': 'Boyei malamu na SpeedNet RDC',
    'Select Congo or Angola and sign in with your mobile number': 'Pona Congo to Angola mpe kota na nimero ya telefone',
    'Choose your country': 'Pona ekolo na yo',
    'Secure OTP verification for your SpeedNet account': 'Verification OTP ya sekele mpo na compte SpeedNet na yo',
    'Congo': 'Congo',
    'Angola': 'Angola',
    'Fast': 'Mbangu',
    'Coverage': 'Couverture',
    'Support': 'Lisungi',
    'OTP login': 'Kokota na OTP',
    '24/7 help': 'Lisungi 24/7',
    'Premium digital self-care': 'Self-care digital ya kitoko',
    'Secure': 'Ya sekele',
    'Congo and Angola users can sign in with OTP and manage bundles, payments and eSIM orders from one SpeedNet account.': 'Ba client ya Congo mpe Angola bakoki kokota na OTP mpe kotambwisa forfaits, futeli mpe ba commandes eSIM na compte SpeedNet moko.',
    'eSIM Ready': 'eSIM ezali prêt',
    'Fast OTP': 'OTP ya mbangu',
    'Selected country': 'Ekolo oponi',
    'Please wait...': 'Zela moke...',
    'Sending OTP...': 'Kotinda OTP...',
    'OTP sent. Enter OTP code.': 'OTP etindami. Tia code OTP.',
    'First press Send OTP': 'Fina liboso Tinda OTP',
    'Please enter OTP code': 'Tia code OTP',
    'Invalid OTP': 'OTP ezali malamu te',
    'OTP failed': 'OTP elongi te',
    'Error': 'Erreur',
    'Please enter a valid number for': 'Tia nimero ya malamu mpo na',
    'All original web bundle pages in premium mobile column layout.': 'Ba page nyonso ya forfait ya web na mobile design ya kitoko.',
    'Bundle Pages': 'Ba page ya forfait',
    'packages available': 'forfaits ezali',
    'Choose a package below.': 'Pona forfait awa na se.',
    'SpeedNet packages from your original web project.': 'Ba forfait SpeedNet ya projet web na yo.',
    'SpeedNet package is available for activation': 'Forfait SpeedNet ezali mpo na activation',
    'This package is unavailable/discontinued. QR generation blocked.': 'Forfait oyo ezali te/esili. QR ekangami.',
    'Original web offers with premium black-purple-gold design.': 'Ba offres ya web na design noir-violet-or.',
    'Offer ID:': 'ID ya offre:',
    'SpeedNet Bundle': 'Forfait SpeedNet',
    'Choose Payment Provider': 'Pona lolenge ya kofuta',
    'Manual Payment': 'Futeli ya maboko',
    'Choose wallet, enter payment ID and upload screenshot.': 'Pona wallet, tia ID ya futeli mpe capture.',
    'Send payment to:': 'Tinda mbongo na:',
    'Upload Payment Screenshot': 'Tia elilingi ya futeli',
    'Please enter Payment ID and upload screenshot.': 'Tia ID ya futeli mpe elilingi.',
    'Payment submitted via': 'Futeli etindami na',
    'for admin approval.': 'mpo admin andima.',
    'SpeedNet call center & key contacts.': 'Centre d’appel SpeedNet mpe ba contacts.',
    'Web demo of your free SMS screen.': 'Demo ya écran SMS ya ofele.',
    'SpeedNet RDC service policy.': 'Mibeko ya service SpeedNet RDC.',
    'SpeedNet RDC premium service page.': 'Page ya service premium SpeedNet RDC.',
    'View all': 'Tala nyonso',
    'Skip': 'Leka',
    'OPEN': 'EFUNGWAMI',
    'Bundle Details': 'Makambo ya forfait',
    'Airtel Money': 'Airtel Money',
    'Orange Money': 'Orange Money',
    'Unitel Money': 'Unitel Money',
    'English': 'Anglais', 'French': 'Français', 'Portuguese': 'Portugais', 'Lingala': 'Lingala',
    'No': 'Te',
    'Backend preserved': 'Backend ebatelami',
    'Manual Approval': 'Kondima ya maboko',
    'Admin will verify payment': 'Admin akotala futeli',
    'Wallet Number': 'Nimero ya wallet',
    'Account Name': 'Kombo ya compte',
    'Enter payment reference': 'Tia référence ya futeli',
    'Tap to select screenshot image': 'Fina mpo na kopona elilingi',
    'Note / WhatsApp Number': 'Note / Nimero WhatsApp',
    'Optional note for admin': 'Note ya kobakisa mpo admin',
    'Internet': 'Internet',
    'Special Bundles': 'Ba forfait ya sipesiale',
    'Voice': 'Mongongo',
    'Neighbour Kitoko Packages': 'Ba forfait Neighbour Kitoko',
    'SMS Packages': 'Ba forfait SMS',
    'International Packages': 'Ba forfait international',
    'Roaming Packages': 'Ba forfait roaming',
    'Sunday Package': 'Forfait ya dimanche',
    'Mega Boss Packages': 'Ba forfait Mega Boss',
    '25 Years of Africa Packages': 'Ba forfait 25 ans ya Afrika',
    'How to buy bundles?': 'Ndenge nini kosomba forfait?',
    'Open Bundles, choose package, press Buy and submit manual payment.': 'Fungola Forfaits, pona forfait, fina Somba mpe tinda futeli ya maboko.',
    'How eSIM QR comes?': 'QR ya eSIM ekoya ndenge nini?',
    'After admin approval backend calls SpeedNet mapped package and generates QR.': 'Sima ya admin kondima, backend ebenga forfait SpeedNet mpe esala QR.',
    'Which payment method?': 'Lolenge nini ya kofuta?',
    'Manual payment through Airtel Money / Unitel Money.': 'Futeli ya maboko na Airtel Money / Unitel Money.',
    'SpeedNet Digital Self-Care for Congo & Angola.': 'Self-care digital SpeedNet mpo na Congo & Angola.',
    'Value Added Services from the uploaded SpeedNet web project.': 'Ba services VAS ya projet web SpeedNet.',
    'Transfer credit/share data services.': 'Service ya kotinda crédit/kokabola data.',
    'Line Recharge with manual payment method.': 'Recharge ya ligne na futeli ya maboko.',
    'Your eSIMs, active bundles and order status.': 'Ba eSIM na yo, forfait active mpe état ya commande.',
    'SpeedRadio page from the web project.': 'Page SpeedRadio ya projet web.',
  };

  final table = lang == 'French' ? fr : lang == 'Portuguese' ? pt : lang == 'Lingala' ? ln : <String, String>{};
  if (table.containsKey(text)) return table[text]!;

  var out = text;
  table.forEach((k, v) { out = out.replaceAll(k, v); });

  out = out.replaceAllMapped(RegExp(r'Validity:\s*(\d+)\s*Days?', caseSensitive: false), (m) {
    final n = m.group(1)!;
    if (lang == 'French') return 'Validité : $n jour${n == '1' ? '' : 's'}';
    if (lang == 'Portuguese') return 'Validade: $n dia${n == '1' ? '' : 's'}';
    return 'Validité: mikolo $n';
  });
  out = out.replaceAllMapped(RegExp(r'Validity:\s*(\d+)\s*Hour', caseSensitive: false), (m) {
    final n = m.group(1)!;
    if (lang == 'French') return 'Validité : $n heure${n == '1' ? '' : 's'}';
    if (lang == 'Portuguese') return 'Validade: $n hora${n == '1' ? '' : 's'}';
    return 'Validité: ngonga $n';
  });
  out = out.replaceAll('Validity:', lang == 'Portuguese' ? 'Validade:' : 'Validité :');
  out = out.replaceAll('days', lang == 'French' ? 'jours' : lang == 'Portuguese' ? 'dias' : 'mikolo');
  out = out.replaceAll('day', lang == 'French' ? 'jour' : lang == 'Portuguese' ? 'dia' : 'mokolo');
  out = out.replaceAll('hours', lang == 'French' ? 'heures' : lang == 'Portuguese' ? 'horas' : 'ngonga');
  out = out.replaceAll('hour', lang == 'French' ? 'heure' : lang == 'Portuguese' ? 'hora' : 'ngonga');
  return out;
}

class SpeednetLivePackage {
  final String id;
  final String type;
  final int amount;
  final int day;
  final String? voice;
  final String? text;

  const SpeednetLivePackage({
    required this.id,
    required this.type,
    required this.amount,
    required this.day,
    this.voice,
    this.text,
  });
}

const List<SpeednetLivePackage> speednetFallbackLivePackages = [
  SpeednetLivePackage(id: 'pondu-mobile-in-7days-1gb', type: 'sim', amount: 1024, day: 7),
  SpeednetLivePackage(id: 'pondu-mobile-in-15days-2gb', type: 'sim', amount: 2048, day: 15),
  SpeednetLivePackage(id: 'pondu-mobile-in-30days-3gb', type: 'sim', amount: 3072, day: 30),
  SpeednetLivePackage(id: 'pondu-mobile-in-30days-5gb', type: 'sim', amount: 5120, day: 30),
  SpeednetLivePackage(id: 'pondu-mobile-in-30days-10gb', type: 'sim', amount: 10240, day: 30),
];

int speednetParseMb(String text) {
  final upper = text.toUpperCase().replaceAll(',', ' ').replaceAll('\u00A0', ' ');
  int best = 0;
  for (final m in RegExp(r'(\d+(?:\.\d+)?)\s*GB\b').allMatches(upper)) {
    best = [best, (double.parse(m.group(1)!) * 1024).ceil()].reduce((a, b) => a > b ? a : b);
  }
  for (final m in RegExp(r'(\d+(?:\.\d+)?)\s*MB\b').allMatches(upper)) {
    best = [best, double.parse(m.group(1)!).ceil()].reduce((a, b) => a > b ? a : b);
  }
  return best;
}

int speednetParseDays(String text) {
  final lower = text.toLowerCase().replaceAll('–', '-').replaceAll('—', '-').replaceAll('\u00A0', ' ');
  final day = RegExp(r'(\d+(?:\.\d+)?)\s*day').firstMatch(lower);
  if (day != null) return double.parse(day.group(1)!).ceil();
  if (RegExp(r'(\d+(?:\.\d+)?)\s*hour|\b(\d+)h\b').hasMatch(lower)) return 1;
  if (RegExp(r'00\s*h|night|nuit|4:59|4h59').hasMatch(lower)) return 1;
  return 0;
}

bool speednetOfferHasNonDataUnits(String text) {
  return RegExp(r'\b(min|mins|minute|minutes|sms|voice|call|appel|chamada)\b', caseSensitive: false).hasMatch(text);
}

bool speednetIsDataOnlyPkg(SpeednetLivePackage pkg) {
  if (pkg.type != 'sim') return false;
  if ((pkg.voice ?? '').isNotEmpty || (pkg.text ?? '').isNotEmpty) return false;
  return true;
}

SpeednetLivePackage? speednetFindFitPackage(String description) {
  final requestedMb = speednetParseMb(description);
  final requestedDays = speednetParseDays(description);
  if (requestedMb <= 0) return null;
  if (speednetOfferHasNonDataUnits(description)) return null;

  final candidates = <Map<String, dynamic>>[];
  for (final pkg in speednetFallbackLivePackages) {
    if (!speednetIsDataOnlyPkg(pkg)) continue;
    if (pkg.amount >= requestedMb && (requestedDays <= 0 || pkg.day >= requestedDays)) {
      candidates.add({
        'pkg': pkg,
        'extraMb': pkg.amount - requestedMb,
        'extraDays': requestedDays <= 0 ? 0 : (pkg.day - requestedDays),
      });
    }
  }
  candidates.sort((a, b) {
    final byMb = (a['extraMb'] as int).compareTo(b['extraMb'] as int);
    if (byMb != 0) return byMb;
    return (a['extraDays'] as int).compareTo(b['extraDays'] as int);
  });
  return candidates.isEmpty ? null : candidates.first['pkg'] as SpeednetLivePackage;
}

String speednetMatchedPackageId(String name, String validity, String price) {
  return speednetFindFitPackage('$name $validity $price')?.id ?? '';
}

bool speednetIsAvailable(String name, String validity, String price) {
  return speednetMatchedPackageId(name, validity, price).isNotEmpty;
}





class AvailabilityBadge extends StatelessWidget {
  final bool available;
  AvailabilityBadge({super.key, required this.available});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: available ? const Color(0xFF16A34A) : const Color(0xFFDC2626),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: (available ? const Color(0xFF16A34A) : const Color(0xFFDC2626)).withOpacity(.25),
            blurRadius: 14,
          ),
        ],
      ),
      child: Text(
        available ? tr('available') : tr('unavailable'),
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w900,
          fontSize: 11,
        ),
      ),
    );
  }
}

class DisabledBuyButton extends StatelessWidget {
  const DisabledBuyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: .55,
      child: ElevatedButton(
        onPressed: null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: Text(tr('unavailable')),
      ),
    );
  }
}


class BundlesPage extends StatefulWidget {
  const BundlesPage({super.key});

  @override
  State<BundlesPage> createState() => _BundlesPageState();
}

class _BundlesPageState extends State<BundlesPage> {
  String? selected;

  @override
  Widget build(BuildContext context) {
    final keys = bundleData.keys.toList();
    selected ??= keys.first;

    return Shell(
      title: tr('bundles'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PremiumPageHeader(
            title: tr('bundles'),
            subtitle: trText('All original web bundle pages in premium mobile column layout.'),
            icon: Icons.wifi_tethering,
          ),
          const SizedBox(height: 20),
          Text(trText('Bundle Pages'), style: TextStyle(fontSize: 21, fontWeight: FontWeight.w900)),
          const SizedBox(height: 10),

          ...keys.map((name) => PremiumColumnCard(
            icon: _bundleIcon(name),
            title: trText(name),
            subtitle: '${(bundleData[name] as List).length} ${trText('packages available')}',
            badge: selected == name ? trText('OPEN') : null,
            onTap: () => push(context, BundleCategoryPage(title: name)),
          )),

          const SizedBox(height: 10),
          Text(trText(selected!), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
          const SizedBox(height: 6),
          Text(trText('Choose a package below.'), style: TextStyle(color: Colors.white70)),
          const SizedBox(height: 12),

          ...(bundleData[selected] as List).map(
            (b) => PremiumPackageColumnCard(
              name: b[0],
              validity: b[1],
              price: b[2],
              onBuy: () => push(context, BuyPage(name: b[0], validity: b[1], price: b[2])),
            ),
          ),
        ],
      ),
    );
  }

  static IconData _bundleIcon(String s) {
    final v = s.toLowerCase();
    if (v.contains('internet')) return Icons.wifi;
    if (v.contains('voice')) return Icons.phone_in_talk;
    if (v.contains('sms')) return Icons.sms;
    if (v.contains('roaming')) return Icons.public;
    if (v.contains('sunday')) return Icons.wb_sunny;
    if (v.contains('mega')) return Icons.workspace_premium;
    if (v.contains('international')) return Icons.flight_takeoff;
    return Icons.inventory_2;
  }
}


class PremiumPackageColumnCard extends StatelessWidget {
  final String name, validity, price;
  final VoidCallback onBuy;

  const PremiumPackageColumnCard({
    super.key,
    required this.name,
    required this.validity,
    required this.price,
    required this.onBuy,
  });

  @override
  Widget build(BuildContext context) {
    final available = speednetIsAvailable(name, validity, price);

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(colors: [Color(0xFF241044), Color(0xFF0A0412)]),
        border: Border.all(color: available ? purple.withOpacity(.30) : Colors.red.withOpacity(.45)),
        boxShadow: [
          BoxShadow(
            color: available ? purple.withOpacity(.16) : Colors.red.withOpacity(.14),
            blurRadius: 22,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: available ? const [purple, blue] : const [Colors.grey, Colors.black45],
                  ),
                  boxShadow: [BoxShadow(color: purple.withOpacity(.25), blurRadius: 18)],
                ),
                child: const Icon(Icons.wifi, color: Colors.white, size: 31),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(trText(name), style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 4),
                  Text(trText(validity), style: const TextStyle(color: Colors.white70)),
                  const SizedBox(height: 8),
                  AvailabilityBadge(available: available),
                ]),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(color: available ? gold : Colors.grey.shade700, borderRadius: BorderRadius.circular(14)),
                child: Text(price, style: TextStyle(color: available ? Colors.black : Colors.white70, fontWeight: FontWeight.w900)),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.white.withOpacity(.045), borderRadius: BorderRadius.circular(18)),
            child: Row(
              children: [
                Icon(available ? Icons.check_circle : Icons.block, color: available ? green : Colors.red, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    available
                        ? tr('speednet_package_available')
                        : tr('speednet_package_unavailable'),
                    style: const TextStyle(color: Colors.white60, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          available ? PremiumBuyButton(text: tr('buy'), onTap: onBuy) : const DisabledBuyButton(),
        ],
      ),
    );
  }
}

class BundleCategoryPage extends StatelessWidget {
  final String title;
  const BundleCategoryPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final packages = (bundleData[title] as List?) ?? [];

    return Shell(
      title: trText(title),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PremiumPageHeader(
            title: trText(title),
            subtitle: trText('SpeedNet packages from your original web project.'),
            icon: _iconFor(title),
          ),
          const SizedBox(height: 18),
          ...packages.map(
            (b) => PremiumPackageColumnCard(
              name: b[0],
              validity: b[1],
              price: b[2],
              onBuy: () => push(
                context,
                BuyPage(name: b[0], validity: b[1], price: b[2]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static IconData _iconFor(String s) {
    final v = s.toLowerCase();
    if (v.contains('sms')) return Icons.sms;
    if (v.contains('voice')) return Icons.phone_in_talk;
    if (v.contains('roaming')) return Icons.public;
    if (v.contains('sunday')) return Icons.wb_sunny;
    if (v.contains('mega')) return Icons.workspace_premium;
    if (v.contains('international')) return Icons.flight_takeoff;
    return Icons.wifi;
  }
}

class SpecialOffersPage extends StatelessWidget {
  const SpecialOffersPage({super.key});

  @override
  Widget build(BuildContext context) => Shell(
    title: tr('special'),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PremiumPageHeader(
          title: tr('special'),
          subtitle: trText('Original web offers with premium black-purple-gold design.'),
          icon: Icons.local_offer,
        ),
        const SizedBox(height: 18),
        ...specialData.map((o) => PremiumSpecialOfferCard(
          id: o[0],
          name: o[1],
          validity: o[2],
          price: o[3],
          onBuy: () => push(context, BuyPage(name: o[1], validity: o[2], price: o[3], id: o[0])),
        )),
      ],
    ),
  );
}


class PremiumSpecialOfferCard extends StatelessWidget {
  final String id, name, validity, price;
  final VoidCallback onBuy;

  const PremiumSpecialOfferCard({
    super.key,
    required this.id,
    required this.name,
    required this.validity,
    required this.price,
    required this.onBuy,
  });

  @override
  Widget build(BuildContext context) {
    final available = speednetIsAvailable(name, validity, price);

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(colors: [Color(0xFF30105D), Color(0xFF0B0414)]),
        border: Border.all(color: available ? purple.withOpacity(.30) : Colors.red.withOpacity(.45)),
        boxShadow: [
          BoxShadow(color: available ? purple.withOpacity(.18) : Colors.red.withOpacity(.14), blurRadius: 26, offset: const Offset(0, 14)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 58,
                width: 58,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(colors: available ? const [purple, blue] : const [Colors.grey, Colors.black45]),
                ),
                child: const Icon(Icons.card_giftcard, color: Colors.white, size: 30),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(trText(name), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 3),
                  Text(trText(validity), style: const TextStyle(color: Colors.white70)),
                  const SizedBox(height: 8),
                  AvailabilityBadge(available: available),
                ]),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(color: available ? gold : Colors.grey.shade700, borderRadius: BorderRadius.circular(14)),
                child: Text(price, style: TextStyle(color: available ? Colors.black : Colors.white70, fontWeight: FontWeight.w900)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text('${trText('Offer ID:')} $id', style: const TextStyle(color: Colors.white38, fontSize: 12)),
          const SizedBox(height: 14),
          available ? PremiumBuyButton(text: tr('claim'), onTap: onBuy) : const DisabledBuyButton(),
        ],
      ),
    );
  }
}

class BuyPage extends StatelessWidget {
  final String name, validity, price;
  final String? id;

  const BuyPage({
    super.key,
    required this.name,
    required this.validity,
    required this.price,
    this.id,
  });

  @override
  Widget build(BuildContext context) => Shell(
    title: tr('bundle_details'),
    child: Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: const LinearGradient(colors: [Color(0xFF5B21B6), Color(0xFF1C0735)]),
            boxShadow: [BoxShadow(color: purple.withOpacity(.35), blurRadius: 30, offset: const Offset(0, 16))],
            border: Border.all(color: purple.withOpacity(.45)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.wifi, color: Colors.white, size: 46),
              const SizedBox(height: 14),
              Text(trText(name), style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900)),
              const SizedBox(height: 4),
              Text(trText('SpeedNet Bundle'), style: TextStyle(color: Colors.white70)),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(color: gold, borderRadius: BorderRadius.circular(16)),
                  child: Text(price, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w900)),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        CardX(
          child: Column(
            children: [
              PremiumInfoRow(tr('validity'), validity.replaceAll('Validity: ', '')),
              PremiumInfoRow(tr('package'), name),
              PremiumInfoRow(tr('network_lbl'), '4G/3G/2G'),
              PremiumInfoRow(tr('auto_renew'), trText('No')),
              PremiumInfoRow(tr('payment_method'), tr('manual_payment')),
              PremiumInfoRow(tr('speednet_mapping'), id ?? trText('Backend preserved')),
            ],
          ),
        ),
        const SizedBox(height: 12),
        PremiumBuyButton(
          text: tr('review_order'),
          onTap: () {
            final available = speednetIsAvailable(name, validity, price);
            if (!available) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(tr('speednet_package_unavailable'))),
              );
              return;
            }
            push(context, PaymentPage(name: name, price: price));
          },
        ),
      ],
    ),
  );
}



class PaymentPage extends StatefulWidget {
  final String name, price;

  const PaymentPage({
    super.key,
    required this.name,
    required this.price,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String provider = 'Airtel Money';
  String? screenshotName;

  final paymentIdCtrl = TextEditingController();
  final noteCtrl = TextEditingController();

  @override
  void dispose() {
    paymentIdCtrl.dispose();
    noteCtrl.dispose();
    super.dispose();
  }

  Future<void> pickScreenshot() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
        withData: false,
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          screenshotName = result.files.single.name;
        });
      }
    } catch (e) {
      setState(() {
        screenshotName = 'Screenshot selected';
      });
    }
  }

  @override
  Widget build(BuildContext context) => Shell(
    title: tr('manual_payment'),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PremiumPageHeader(
          title: tr('manual_payment'),
          subtitle: trText('Choose wallet, enter payment ID and upload screenshot.'),
          icon: Icons.payments,
        ),
        const SizedBox(height: 18),

        CardX(
          child: Column(
            children: [
              PremiumInfoRow(tr('selected_package'), widget.name),
              PremiumInfoRow(tr('amount'), widget.price, highlight: true),
              PremiumInfoRow(trText('Manual Approval'), trText('Admin will verify payment')),
            ],
          ),
        ),

        const SizedBox(height: 10),
        Text(trText('Choose Payment Provider'), style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
        const SizedBox(height: 12),

        ManualProviderCard(
          title: trText('Airtel Money'),
          number: '+243892399476',
          selected: provider == 'Airtel Money',
          iconColor: Colors.red,
          onTap: () => setState(() => provider = 'Airtel Money'),
        ),
        ManualProviderCard(
          title: trText('Orange Money'),
          number: '+24399969296',
          selected: provider == 'Orange Money',
          iconColor: Colors.orange,
          onTap: () => setState(() => provider = 'Orange Money'),
        ),
        ManualProviderCard(
          title: trText('Unitel Money'),
          number: '+243823778982',
          selected: provider == 'Unitel Money',
          iconColor: purple,
          onTap: () => setState(() => provider = 'Unitel Money'),
        ),

        const SizedBox(height: 14),
        CardX(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${trText('Send payment to:')} $provider', style: const TextStyle(fontWeight: FontWeight.w900)),
              const SizedBox(height: 8),
              PremiumInfoRow(
                trText('Wallet Number'),
                provider == 'Airtel Money'
                    ? '+243892399476'
                    : provider == 'Orange Money'
                        ? '+24399969296'
                        : '+243823778982',
                highlight: true,
              ),
              PremiumInfoRow(trText('Account Name'), 'SpeedNet RDC'),
            ],
          ),
        ),

        const SizedBox(height: 12),
        TextField(
          controller: paymentIdCtrl,
          decoration: InputDecoration(
            labelText: tr('payment_id'),
            hintText: trText('Enter payment reference'),
            filled: true,
            fillColor: card2,
            prefixIcon: const Icon(Icons.receipt_long, color: gold),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
          ),
        ),

        const SizedBox(height: 12),
        GestureDetector(
          onTap: pickScreenshot,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              color: card2.withOpacity(.9),
              border: Border.all(color: screenshotName == null ? Colors.white12 : green.withOpacity(.65)),
              boxShadow: [BoxShadow(color: purple.withOpacity(.10), blurRadius: 18)],
            ),
            child: Row(
              children: [
                Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: const LinearGradient(colors: [purple, blue]),
                  ),
                  child: Icon(screenshotName == null ? Icons.upload_file : Icons.check, color: Colors.white),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(tr('upload_screenshot'), style: TextStyle(fontWeight: FontWeight.w900)),
                      const SizedBox(height: 4),
                      Text(
                        screenshotName ?? trText('Tap to select screenshot image'),
                        style: const TextStyle(color: Colors.white60, fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: gold),
              ],
            ),
          ),
        ),

        const SizedBox(height: 12),
        TextField(
          controller: noteCtrl,
          maxLines: 3,
          decoration: InputDecoration(
            labelText: trText('Note / WhatsApp Number'),
            hintText: trText('Optional note for admin'),
            filled: true,
            fillColor: card2,
            prefixIcon: const Icon(Icons.note_alt, color: gold),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
          ),
        ),

        const SizedBox(height: 18),
        PremiumBuyButton(
          text: tr('submit_payment'),
          onTap: () {
            if (paymentIdCtrl.text.trim().isEmpty || screenshotName == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(trText('Please enter Payment ID and upload screenshot.'))),
              );
              return;
            }

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${trText('Payment submitted via')} $provider ${trText('for admin approval.')}')),
            );
          },
        ),
      ],
    ),
  );
}

class ManualProviderCard extends StatelessWidget {
  final String title;
  final String number;
  final bool selected;
  final Color iconColor;
  final VoidCallback onTap;

  const ManualProviderCard({
    super.key,
    required this.title,
    required this.number,
    required this.selected,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: selected
            ? const LinearGradient(colors: [Color(0xFF35106A), Color(0xFF140622)])
            : const LinearGradient(colors: [Color(0xFF1E0B35), Color(0xFF0B0618)]),
        border: Border.all(color: selected ? gold.withOpacity(.8) : Colors.white10, width: selected ? 1.6 : 1),
        boxShadow: selected ? [BoxShadow(color: purple.withOpacity(.26), blurRadius: 24, offset: const Offset(0, 12))] : [],
      ),
      child: Row(
        children: [
          Container(
            height: 52,
            width: 52,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: iconColor,
            ),
            child: const Icon(Icons.account_balance_wallet, color: Colors.white),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(trText(title), style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
              const SizedBox(height: 4),
              Text(number, style: const TextStyle(color: Colors.white60)),
            ]),
          ),
          Icon(selected ? Icons.check_circle : Icons.circle_outlined, color: selected ? gold : Colors.white38),
        ],
      ),
    ),
  );
}




class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: appLang,
      builder: (_, __, ___) {
        return Shell(
          title: tr('menu'),
          back: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MenuHeaderCard(),
              const SizedBox(height: 18),
              Text(
                tr('customer'),
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 12),
              ModernMenuTile(
                icon: Icons.call,
                title: tr('useful'),
                subtitle: '+243 999369296',
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const UsefulNumbersPage())),
              ),
              ModernMenuTile(
                icon: Icons.support_agent,
                title: tr('customer'),
                subtitle: tr('network'),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CustomerServicePage())),
              ),
              ModernMenuTile(
                icon: Icons.help,
                title: tr('faqs'),
                subtitle: tr('faqs'),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FaqPage())),
              ),
              ModernMenuTile(
                icon: Icons.sms,
                title: tr('sms'),
                subtitle: tr('send_sms'),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SmsPage())),
              ),
              const SizedBox(height: 10),
              Text(
                tr('settings'),
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 12),
              ModernMenuTile(
                icon: Icons.privacy_tip,
                title: tr('terms'),
                subtitle: 'SpeedNet RDC',
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TermsPage())),
              ),
              ModernMenuTile(
                icon: Icons.info,
                title: tr('about'),
                subtitle: 'SpeedNet RDC',
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutPage())),
              ),
              ModernMenuTile(
                icon: Icons.settings,
                title: tr('settings'),
                subtitle: tr('language'),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsPage())),
              ),
            ],
          ),
        );
      },
    );
  }
}

class MenuHeaderCard extends StatelessWidget {
  const MenuHeaderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 145,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF35106A), Color(0xFF12051F), Color(0xFF06000C)],
        ),
        border: Border.all(color: purple.withOpacity(.35)),
        boxShadow: [
          BoxShadow(
            color: purple.withOpacity(.20),
            blurRadius: 28,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Row(
        children: [
          const AppLogo(size: 72),
          const SizedBox(width: 16),
          Expanded(
            child: ValueListenableBuilder<String>(
              valueListenable: appLang,
              builder: (_, __, ___) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tr('menu'),
                      style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 6),
                    Text('SpeedNet RDC', style: TextStyle(color: Colors.white70)),
                  ],
                );
              },
            ),
          ),
          const Icon(Icons.auto_awesome, color: gold, size: 32),
        ],
      ),
    );
  }
}

class ModernMenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  ModernMenuTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(colors: [Color(0xFF24103A), Color(0xFF12051F)]),
        border: Border.all(color: Colors.white10),
        boxShadow: [
          BoxShadow(color: purple.withOpacity(.12), blurRadius: 18, offset: const Offset(0, 10)),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: const LinearGradient(colors: [purple, blue]),
          ),
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(trText(title), style: const TextStyle(fontWeight: FontWeight.w900)),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.white60, fontSize: 12)),
        trailing: const Icon(Icons.arrow_forward_ios, color: gold, size: 17),
      ),
    );
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool sound = true;
  bool notifications = true;
  bool vibration = true;
  bool darkMode = true;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<String>(
    valueListenable: appLang,
    builder: (_, __, ___) => Shell(
      title: tr('settings'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PremiumPageHeader(title: tr('settings'), subtitle: '${tr('language')}, ${tr('sound')}, ${tr('notifications')}', icon: Icons.settings),
          const SizedBox(height: 18),
          CardX(
            child: Row(
              children: [
                const Icon(Icons.language, color: gold),
                const SizedBox(width: 14),
                Expanded(child: Text(tr('language'), style: const TextStyle(fontWeight: FontWeight.w900))),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), border: Border.all(color: gold.withOpacity(.45))),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: appLang.value,
                      dropdownColor: card2,
                      items: [
                        DropdownMenuItem(value: 'English', child: Text(trText('English'))),
                        DropdownMenuItem(value: 'French', child: Text(trText('French'))),
                        DropdownMenuItem(value: 'Portuguese', child: Text(trText('Portuguese'))),
                        DropdownMenuItem(value: 'Lingala', child: Text(trText('Lingala'))),
                      ],
                      onChanged: (v) {
                        if (v != null) appLang.value = v;
                        setState(() {});
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          _settingSwitch(Icons.volume_up, tr('sound'), sound, (v) => setState(() => sound = v)),
          _settingSwitch(Icons.notifications, tr('notifications'), notifications, (v) => setState(() => notifications = v)),
          _settingSwitch(Icons.vibration, tr('vibration'), vibration, (v) => setState(() => vibration = v)),
          _settingSwitch(Icons.dark_mode, tr('dark'), darkMode, (v) => setState(() => darkMode = v)),
        ],
      ),
    ),
  );

  Widget _settingSwitch(IconData icon, String title, bool value, ValueChanged<bool> onChanged) => CardX(
    child: Row(
      children: [
        Icon(icon, color: gold),
        const SizedBox(width: 14),
        Expanded(child: Text(trText(title), style: const TextStyle(fontWeight: FontWeight.w900))),
        Switch(value: value, onChanged: onChanged, activeColor: gold),
      ],
    ),
  );
}


class UsefulNumbersPage extends StatelessWidget {
  const UsefulNumbersPage({super.key});

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<String>(
    valueListenable: appLang,
    builder: (_, __, ___) => Shell(
      title: tr('useful'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PremiumPageHeader(title: tr('useful'), subtitle: trText('SpeedNet call center & key contacts.'), icon: Icons.call),
          const SizedBox(height: 18),
          PremiumColumnCard(icon: Icons.support_agent, title: tr('call'), subtitle: '+243 999369296'),
          PremiumColumnCard(icon: Icons.email, title: tr('email'), subtitle: 'contact@speednetrdc.com'),
          PremiumColumnCard(icon: Icons.chat, title: tr('whatsapp'), subtitle: '+243 999369296'),
        ],
      ),
    ),
  );
}


class CustomerServicePage extends StatelessWidget {
  const CustomerServicePage({super.key});

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<String>(
    valueListenable: appLang,
    builder: (_, __, ___) => Shell(
      title: tr('customer'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PremiumPageHeader(title: tr('customer'), subtitle: tr('topic'), icon: Icons.support_agent),
          const SizedBox(height: 18),
          CardX(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tr('topic'), style: const TextStyle(fontWeight: FontWeight.w900)),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: tr('network'),
                  dropdownColor: card2,
                  decoration: InputDecoration(filled: true, fillColor: bg, border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none)),
                  items: [tr('network'), 'Payment support', 'Bundle support', 'eSIM support'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                  onChanged: (_) {},
                ),
                const SizedBox(height: 14),
                TextField(
                  maxLines: 5,
                  maxLength: 250,
                  decoration: InputDecoration(
                    hintText: '${tr('message')} (max 250 characters)',
                    filled: true,
                    fillColor: bg,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 12),
                PremiumBuyButton(text: tr('send_req'), onTap: () {}),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class FaqPage extends StatelessWidget{const FaqPage({super.key});@override Widget build(BuildContext context)=>Shell(title: tr('faqs'),child:Column(children:[Faq(trText('How to buy bundles?'),trText('Open Bundles, choose package, press Buy and submit manual payment.')),Faq(trText('How eSIM QR comes?'),trText('After admin approval backend calls SpeedNet mapped package and generates QR.')),Faq(trText('Which payment method?'),trText('Manual payment through Airtel Money / Unitel Money.'))])) ;}

class SmsPage extends StatelessWidget {
  const SmsPage({super.key});

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<String>(
    valueListenable: appLang,
    builder: (_, __, ___) => Shell(
      title: tr('sms'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PremiumPageHeader(title: tr('send_sms'), subtitle: trText('Web demo of your free SMS screen.'), icon: Icons.sms),
          const SizedBox(height: 18),
          CardX(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(18), border: Border.all(color: gold.withOpacity(.35))),
                      child: Text('+243', style: TextStyle(fontWeight: FontWeight.w900)),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: 'Mobile number',
                          filled: true,
                          fillColor: bg,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                TextField(
                  maxLines: 6,
                  decoration: InputDecoration(
                    hintText: tr('message'),
                    filled: true,
                    fillColor: bg,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 14),
                PremiumBuyButton(text: tr('send_sms'), onTap: () {}),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}


class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<String>(
    valueListenable: appLang,
    builder: (_, __, ___) => Shell(
      title: tr('terms'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PremiumPageHeader(title: tr('terms'), subtitle: trText('SpeedNet RDC service policy.'), icon: Icons.privacy_tip),
          const SizedBox(height: 18),
          CardX(
            child: Text(
              'SpeedNet RDC provides digital self-care services for Congo and Angola including bundles, special offers, line recharge, VAS, SpeedRadio, customer service and eSIM related services. By using this app, the user agrees that all bundle purchases, manual payment submissions and service requests must contain correct information. Manual payments are verified by the SpeedNet admin team before activation. After approval, eligible eSIM or bundle orders may be processed through the connected backend system. SpeedNet is not responsible for wrong phone numbers, wrong transaction IDs, unclear screenshots, or payments sent to incorrect accounts. User contact information is used only for order processing, customer support, subscription status and service notifications. SpeedNet may update package prices, validity, availability and service terms according to business or provider requirements.',
              style: TextStyle(height: 1.55, color: Colors.white70),
            ),
          ),
        ],
      ),
    ),
  );
}

class AboutPage extends StatelessWidget{const AboutPage({super.key});@override Widget build(BuildContext context)=>TextPage(title: tr('about'),body:trText('SpeedNet Digital Self-Care for Congo & Angola.'));}
class VasPage extends StatelessWidget{const VasPage({super.key});@override Widget build(BuildContext context)=>TextPage(title: tr('vas'),body:trText('Value Added Services from the uploaded SpeedNet web project.'));}
class CreditTransferPage extends StatelessWidget{const CreditTransferPage({super.key});@override Widget build(BuildContext context)=>TextPage(title: tr('credit'),body:trText('Transfer credit/share data services.'));}
class RechargePage extends StatelessWidget{const RechargePage({super.key});@override Widget build(BuildContext context)=>TextPage(title: tr('recharge'),body:trText('Line Recharge with manual payment method.'));}
class MySubscriptionsPage extends StatelessWidget{const MySubscriptionsPage({super.key});@override Widget build(BuildContext context)=>TextPage(title: tr('subs'),body:trText('Your eSIMs, active bundles and order status.'));}
class SpeedRadioPage extends StatelessWidget{const SpeedRadioPage({super.key});@override Widget build(BuildContext context)=>TextPage(title: tr('radio'),body:trText('SpeedRadio page from the web project.'));}

class Shell extends StatelessWidget{
  final String title; final Widget child; final bool back; final Widget? titleWidget;
  const Shell({super.key,required this.title,required this.child,this.back=true,this.titleWidget});
  @override Widget build(BuildContext context)=>ValueListenableBuilder<String>(
    valueListenable: appLang,
    builder: (_, __, ___) => Scaffold(
      appBar:AppBar(
        leading:back&&Navigator.canPop(context)?IconButton(icon:const Icon(Icons.arrow_back),onPressed:()=>Navigator.pop(context)):null,
        title:titleWidget??Text(trText(title)),
      ),
      body:Container(
        decoration:const BoxDecoration(gradient:LinearGradient(begin:Alignment.topCenter,end:Alignment.bottomCenter,colors:[Color(0xFF090014),Color(0xFF05000C)])),
        child:SafeArea(top:false,child:SingleChildScrollView(padding:const EdgeInsets.all(16),child:child)),
      ),
    ),
  );
}
class BannerBox extends StatelessWidget{final String image; final bool large; const BannerBox({super.key,required this.image,this.large=false});@override Widget build(BuildContext context)=>Container(decoration:BoxDecoration(borderRadius:BorderRadius.circular(24),border:Border.all(color:purple.withOpacity(.45)),boxShadow:[BoxShadow(color:purple.withOpacity(.28),blurRadius:26,offset:const Offset(0,12))]),clipBehavior:Clip.antiAlias,child:Image.asset('assets/images/$image',fit:BoxFit.cover,width:double.infinity,height:large?double.infinity:null));}
class Q extends StatelessWidget{final IconData icon; final String label; final VoidCallback tap; const Q(this.icon,this.label,this.tap,{super.key});@override Widget build(BuildContext context)=>GestureDetector(onTap:tap,child:Container(decoration:BoxDecoration(color:card2,borderRadius:BorderRadius.circular(16),border:Border.all(color:Colors.white10)),child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[Icon(icon,color:gold),const SizedBox(height:6),Text(label,textAlign:TextAlign.center,style:const TextStyle(fontSize:10))])));}
class PlanTile extends StatelessWidget{final String name,validity,price; final String? id; final VoidCallback onBuy; const PlanTile({super.key,required this.name,required this.validity,required this.price,this.id,required this.onBuy});@override Widget build(BuildContext context)=>CardX(child:Row(children:[Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(trText(name),style:const TextStyle(fontSize:24,color:purple,fontWeight:FontWeight.w900)),Text(trText(validity),style:const TextStyle(color:Colors.white70)),if(id!=null)Text(id!,style:const TextStyle(color:Colors.white38,fontSize:11))])),Column(crossAxisAlignment:CrossAxisAlignment.end,children:[Text(price,style:const TextStyle(fontWeight:FontWeight.w900,fontSize:17)),const SizedBox(height:8),SmallBtn(tr('buy'),onBuy)])]));}
class CardX extends StatelessWidget{final Widget child; const CardX({super.key,required this.child});@override Widget build(BuildContext context)=>Container(margin:const EdgeInsets.only(bottom:12),padding:const EdgeInsets.all(15),decoration:BoxDecoration(color:card2.withOpacity(.86),borderRadius:BorderRadius.circular(20),border:Border.all(color:Colors.white10),boxShadow:[BoxShadow(color:purple.withOpacity(.12),blurRadius:18)]),child:child);}
class GoldButton extends StatelessWidget{final String text; final VoidCallback onTap; const GoldButton({super.key,required this.text,required this.onTap});@override Widget build(BuildContext context)=>Container(decoration:BoxDecoration(borderRadius:BorderRadius.circular(22),gradient:const LinearGradient(colors:[gold,Color(0xFFFFA726)]),boxShadow:[BoxShadow(color:gold.withOpacity(.32),blurRadius:22,offset:const Offset(0,10)),BoxShadow(color:purple.withOpacity(.20),blurRadius:26,offset:const Offset(0,12))]),child:ElevatedButton(onPressed:onTap,style:ElevatedButton.styleFrom(backgroundColor:Colors.transparent,shadowColor:Colors.transparent,foregroundColor:Colors.black,minimumSize:const Size(double.infinity,56),shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(22))),child:Row(mainAxisAlignment:MainAxisAlignment.center,children:[const Icon(Icons.rocket_launch,size:18),const SizedBox(width:8),Text(text,style:const TextStyle(fontWeight:FontWeight.w900,letterSpacing:.2)),const SizedBox(width:8),const Icon(Icons.arrow_forward_rounded,size:18)])));}
class SmallBtn extends StatelessWidget{final String t; final VoidCallback f; const SmallBtn(this.t,this.f,{super.key});@override Widget build(BuildContext context)=>ElevatedButton(onPressed:f,style:ElevatedButton.styleFrom(backgroundColor:gold,foregroundColor:Colors.black),child:Text(t));}
class Field extends StatelessWidget{final String label; final TextEditingController? ctrl; final TextInputType? keyboard; const Field({super.key,required this.label,this.ctrl,this.keyboard});@override Widget build(BuildContext context)=>TextField(controller:ctrl,keyboardType:keyboard,decoration:InputDecoration(labelText:label,filled:true,fillColor:card2,border:OutlineInputBorder(borderRadius:BorderRadius.circular(18),borderSide:BorderSide.none)));}
class Header extends StatelessWidget{final String t; final VoidCallback f; const Header(this.t,this.f,{super.key});@override Widget build(BuildContext context)=>Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children:[Text(trText(t),style:const TextStyle(fontSize:18,fontWeight:FontWeight.w900)),TextButton(onPressed:f,child:Text(trText('View all')))]);}
class OfferMini extends StatelessWidget{final dynamic o; const OfferMini({super.key,required this.o});@override Widget build(BuildContext context)=>Container(width:190,margin:const EdgeInsets.only(right:12),padding:const EdgeInsets.all(14),decoration:BoxDecoration(gradient:const LinearGradient(colors:[Color(0xFF351266),Color(0xFF0C0622)]),borderRadius:BorderRadius.circular(20),border:Border.all(color:purple.withOpacity(.35))),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(o[1],style:const TextStyle(fontWeight:FontWeight.w900)),Text(o[2],style:const TextStyle(color:Colors.white70)),const Spacer(),Text(o[3],style:const TextStyle(fontSize:23,color:gold,fontWeight:FontWeight.w900))]));}
class Tabs extends StatelessWidget{final List<String> items; final String sel; final ValueChanged<String> on; const Tabs({super.key,required this.items,required this.sel,required this.on});@override Widget build(BuildContext context)=>SingleChildScrollView(scrollDirection:Axis.horizontal,child:Row(children:items.map((e)=>GestureDetector(onTap:()=>on(e),child:Container(margin:const EdgeInsets.only(right:8),padding:const EdgeInsets.symmetric(horizontal:14,vertical:8),decoration:BoxDecoration(color:e==sel?gold:card2,borderRadius:BorderRadius.circular(30)),child:Text(trText(e),style:TextStyle(color:e==sel?Colors.black:Colors.white,fontWeight:FontWeight.w800))))).toList()));}
class Info extends StatelessWidget{final String a,b; const Info(this.a,this.b,{super.key});@override Widget build(BuildContext context)=>CardX(child:Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children:[Expanded(child:Text(a)),Flexible(child:Text(b,textAlign:TextAlign.right,style:const TextStyle(color:gold,fontWeight:FontWeight.w900)))]));}
class MenuBtn extends StatelessWidget{final String t; final IconData i; final VoidCallback f; const MenuBtn(this.t,this.i,this.f,{super.key});@override Widget build(BuildContext context)=>CardX(child:InkWell(onTap:f,child:Row(children:[Icon(i,color:gold),const SizedBox(width:14),Expanded(child:Text(t)),const Icon(Icons.chevron_right)])));}
class Setting extends StatelessWidget{final String t,v; final IconData i; const Setting(this.t,this.v,this.i,{super.key});@override Widget build(BuildContext context)=>CardX(child:Row(children:[Icon(i,color:gold),const SizedBox(width:14),Expanded(child:Text(t)),Text(v,style:const TextStyle(color:Colors.white70))]));}
class Faq extends StatelessWidget{final String q,a; const Faq(this.q,this.a,{super.key});@override Widget build(BuildContext context)=>CardX(child:ExpansionTile(title:Text(q),children:[Padding(padding:const EdgeInsets.all(10),child:Text(a))]));}
class TextPage extends StatelessWidget {
  final String title, body;
  const TextPage({super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) => Shell(
    title: title,
    child: Column(
      children: [
        PremiumPageHeader(title: title, subtitle: trText('SpeedNet RDC premium service page.'), icon: Icons.auto_awesome),
        const SizedBox(height: 18),
        CardX(child: Text(body, style: const TextStyle(height: 1.5, color: Colors.white70))),
      ],
    ),
  );
}

void push(BuildContext c, Widget p)=>Navigator.push(c,MaterialPageRoute(builder:(_)=>p));

class GlowPurpleButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const GlowPurpleButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(18),
      boxShadow: [BoxShadow(color: purple.withOpacity(.45), blurRadius: 26, offset: const Offset(0, 12))],
    ),
    child: ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 56),
        backgroundColor: purple,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
    ),
  );
}

class PremiumPageHeader extends StatefulWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  PremiumPageHeader({super.key, required this.title, required this.subtitle, required this.icon});

  @override
  State<PremiumPageHeader> createState() => _PremiumPageHeaderState();
}

class _PremiumPageHeaderState extends State<PremiumPageHeader> with SingleTickerProviderStateMixin {
  late AnimationController ac;

  @override
  void initState() {
    super.initState();
    ac = AnimationController(vsync: this, duration: const Duration(seconds: 3))..repeat(reverse: true);
  }

  @override
  void dispose() {
    ac.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: ac,
    builder: (_, __) => Container(
      height: 150,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF35106A), Color(0xFF13051F), Color(0xFF08010F)],
        ),
        border: Border.all(color: purple.withOpacity(.35 + ac.value * .20)),
        boxShadow: [
          BoxShadow(color: purple.withOpacity(.24 + ac.value * .15), blurRadius: 34, offset: const Offset(0, 18)),
          BoxShadow(color: gold.withOpacity(.08), blurRadius: 38),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -12,
            top: -15,
            child: Transform.scale(
              scale: .96 + ac.value * .08,
              child: Icon(widget.icon, size: 128, color: purple.withOpacity(.22)),
            ),
          ),
          Positioned(
            right: 48,
            bottom: 10 + ac.value * 8,
            child: const Icon(Icons.auto_awesome, color: gold, size: 34),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(trText(widget.title), style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900)),
              const SizedBox(height: 8),
              SizedBox(
                width: 230,
                child: Text(trText(widget.subtitle), style: const TextStyle(color: Colors.white70, height: 1.35)),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

class PremiumColumnCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String? badge;
  final VoidCallback? onTap;

  PremiumColumnCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.badge,
    this.onTap,
  });

  @override
  State<PremiumColumnCard> createState() => _PremiumColumnCardState();
}

class _PremiumColumnCardState extends State<PremiumColumnCard> with SingleTickerProviderStateMixin {
  late AnimationController ac;

  @override
  void initState() {
    super.initState();
    ac = AnimationController(vsync: this, duration: const Duration(milliseconds: 2200))..repeat(reverse: true);
  }

  @override
  void dispose() {
    ac.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: ac,
    builder: (_, __) => GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26),
          gradient: const LinearGradient(colors: [Color(0xFF21103A), Color(0xFF0E0519)]),
          border: Border.all(color: purple.withOpacity(.20 + ac.value * .14)),
          boxShadow: [BoxShadow(color: purple.withOpacity(.12 + ac.value * .08), blurRadius: 22, offset: const Offset(0, 12))],
        ),
        child: Row(
          children: [
            Transform.scale(
              scale: .96 + ac.value * .06,
              child: Container(
                height: 58,
                width: 58,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(colors: [purple, blue]),
                  boxShadow: [BoxShadow(color: purple.withOpacity(.35), blurRadius: 20)],
                ),
                child: Icon(widget.icon, color: Colors.white, size: 30),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(trText(widget.title), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
                const SizedBox(height: 5),
                Text(trText(widget.subtitle), style: const TextStyle(color: Colors.white70, height: 1.25)),
              ]),
            ),
            if (widget.badge != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                decoration: BoxDecoration(color: gold, borderRadius: BorderRadius.circular(14)),
                child: Text(widget.badge!, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 12)),
              )
            else
              const Icon(Icons.chevron_right, color: gold),
          ],
        ),
      ),
    ),
  );
}

class PremiumBuyButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const PremiumBuyButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: [BoxShadow(color: purple.withOpacity(.42), blurRadius: 26, offset: const Offset(0, 14))],
    ),
    child: ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: purple,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: .4)),
    ),
  );
}

class PremiumInfoRow extends StatelessWidget {
  final String title, value;
  final bool highlight;
  const PremiumInfoRow(this.title, this.value, {super.key, this.highlight = false});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 9),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Text(trText(title), style: const TextStyle(color: Colors.white70))),
        const SizedBox(width: 12),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(color: highlight ? gold : Colors.white, fontWeight: FontWeight.w900),
          ),
        ),
      ],
    ),
  );
}
