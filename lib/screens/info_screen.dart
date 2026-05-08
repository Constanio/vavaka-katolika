import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  static const Color _bgColor = Color(0xFFF8F5F0);
  static const Color _primaryBlue = Color(0xFF2C4A6B);
  static const Color _gold = Color(0xFFD4AF37);
  static const Color _graySoft = Color(0xFF6B7280);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 140,
            pinned: true,
            backgroundColor: _primaryBlue,
            elevation: 0,
            leading: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white, size: 22),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              titlePadding: const EdgeInsets.only(bottom: 16),
              title: const Text(
                'Momba ny fampiharana',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  letterSpacing: 0.3,
                ),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF2C4A6B),
                      Color(0xFF3D5A80),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -30,
                      top: 10,
                      child: Icon(
                        Icons.menu_book,
                        size: 160,
                        color: _gold.withValues(alpha: 0.1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: _primaryBlue.withValues(alpha: 0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.menu_book,
                        size: 60,
                        color: _primaryBlue,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'Vavaka Katolika',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: _primaryBlue,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: _gold.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Version 1.0.0',
                            style: TextStyle(
                              fontSize: 13,
                              color: _primaryBlue,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  _InfoCard(
                    icon: Icons.info_outline,
                    title: 'Inona ity fampiharana ity?',
                    content: 'Ny "Vavaka Katolika" dia fampiharana ho an\'ny mpivavaka katolika eto Madagasikara. Ahafahanao mijery sy miboky vavaka maro samihafa omen\'ny Fiangonana Katolika.',
                  ),
                  const SizedBox(height: 16),
                  _InfoCard(
                    icon: Icons.church,
                    title: 'Vavaka misy ao',
                    content: 'Misy vavaka telo ambin\'ny folo (20) hatramin\'izao, ahitana ny Rainay any an-danitra, ny Anjelisy, ny Fiekem-pinoana, ny Fitsaohana, ny Fisaorana, ny Fifonana, ny Fanenena, ary ny maro hafa.',
                  ),
                  const SizedBox(height: 16),
                  _InfoCard(
                    icon: Icons.translate,
                    title: 'Fiteny roa',
                    content: 'Ny vavaka rehetra dia misy amin\'ny fiteny malagasy sy frantsay. Afahana mifindra eo amin\'ny fitsipiky ny solosaina mba hijerena ny fiteny tianao.',
                  ),
                  const SizedBox(height: 16),
                  _InfoCard(
                    icon: Icons.search,
                    title: 'Fikarohana',
                    content: 'Azonao atao ny mikaroka vavaka amin\'ny anarana na ny atin\'izy ireo mba hahitana haingana izay tadiavinao.',
                  ),
                  const SizedBox(height: 16),
                  _InfoCard(
                    icon: Icons.category,
                    title: 'Sokajy',
                    content: 'Ny vavaka dia soratana araka ny sokajy: Vavaka maraina sy alina, Maria, Finoana, Sakramenta, Fampidirana, ary Fivavahana.',
                  ),
                  const SizedBox(height: 16),
                  _InfoCard(
                    icon: Icons.favorite,
                    title: 'Fampiasana',
                    content: 'Azonao atao ny manomboka amin\'ny fampiharana amin\'ny torom-pifandraisan\'ny herin\'ny Internet. Tsy mila fampidirana na fanahafana ilaina.',
                  ),
                  const SizedBox(height: 32),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'Naroson\'ny vavaka ho an\'ny mpivavaka',
                          style: TextStyle(
                            fontSize: 14,
                            color: _graySoft.withValues(alpha: 0.7),
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.auto_awesome,
                              size: 14,
                              color: _gold.withValues(alpha: 0.5),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Fiadanana sy fanamasinana',
                              style: TextStyle(
                                fontSize: 13,
                                color: _primaryBlue,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              Icons.auto_awesome,
                              size: 14,
                              color: _gold.withValues(alpha: 0.5),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: _primaryBlue.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: _primaryBlue.withValues(alpha: 0.1),
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.code,
                          color: _graySoft,
                          size: 32,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Namboarin\'ny Reconst',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: _primaryBlue,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Fampiharana ho an\'ny mpivavaka',
                          style: TextStyle(
                            fontSize: 13,
                            color: _graySoft,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '© 2026 Vavaka Katolika',
                          style: TextStyle(
                            fontSize: 12,
                            color: _graySoft.withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.content,
  });

  static const Color _primaryBlue = Color(0xFF2C4A6B);
  static const Color _gold = Color(0xFFD4AF37);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: _primaryBlue.withValues(alpha: 0.06),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _primaryBlue.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: _primaryBlue,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: _primaryBlue,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  content,
                  style: TextStyle(
                    fontSize: 14,
                    color: const Color(0xFF374151),
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}