import 'package:flutter/material.dart';
import '../services/priere_service.dart';
import '../models/priere.dart';
import 'priere_detail_screen.dart';
import 'info_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true;
  List<Priere> _prieres = [];
  String _selectedCategory = 'Tout';
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  static const Color _bgColor = Color(0xFFF8F5F0);
  static const Color _primaryBlue = Color(0xFF2C4A6B);
  static const Color _gold = Color(0xFFD4AF37);
  static const Color _graySoft = Color(0xFF6B7280);

  @override
  void initState() {
    super.initState();
    _loadPrieres();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadPrieres() async {
    await PriereService.loadPrieres();
    setState(() {
      _prieres = PriereService.getPrieres();
      _prieres.sort((a, b) => a.titre.compareTo(b.titre));
      _isLoading = false;
    });
  }

  List<Priere> get _filteredPrieres {
    List<Priere> result;
    
    if (_selectedCategory == 'Tout') {
      result = _prieres;
    } else {
      result = _prieres.where((p) => p.categorie == _selectedCategory).toList();
    }
    
    if (_searchQuery.isNotEmpty) {
      result = result.where((p) => 
        p.titre.toLowerCase().contains(_searchQuery.toLowerCase()) ||
        p.contenu.toLowerCase().contains(_searchQuery.toLowerCase())
      ).toList();
    }
    
    return result..sort((a, b) => a.titre.compareTo(b.titre));
  }

  List<String> get _categories {
    List<String> cats = ['Tout', ...PriereService.getCategories()];
    return cats;
  }

IconData _getCategoryIcon(String categorie) {
    return Icons.menu_book;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 160,
            pinned: true,
            stretch: true,
            toolbarHeight: 60,
            backgroundColor: _primaryBlue,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              titlePadding: const EdgeInsets.only(left: 20, bottom: 18),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.menu_book, color: _gold, size: 20),
                      const SizedBox(width: 8),
                      const Text(
                        'Vavaka Katolika',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Fiadanana sy fanamasinana',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w300,
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF2C4A6B),
                      Color(0xFF3D5A80),
                      Color(0xFF4A6D8C),
                    ],
                    stops: [0.0, 0.5, 1.0],
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -30,
                      top: 20,
                      child: Icon(
                        Icons.church_outlined,
                        size: 180,
                        color: Colors.white.withValues(alpha: 0.06),
                      ),
                    ),
                    Positioned(
                      left: -20,
                      bottom: -10,
                      child: Icon(
                        Icons.circle_outlined,
                        size: 80,
                        color: Colors.white.withValues(alpha: 0.04),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.info_outline, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const InfoScreen(),
                    ),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.bookmark_border, color: Colors.white),
                onPressed: () {},
              ),
              const SizedBox(width: 8),
            ],
          ),
          SliverToBoxAdapter(
            child: Container(
              color: _bgColor,
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: _primaryBlue.withValues(alpha: 0.08),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Flahadio amin\'ny teny...',
                    hintStyle: TextStyle(color: _graySoft.withValues(alpha: 0.6)),
                    prefixIcon: Icon(Icons.search, color: _primaryBlue),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: Icon(Icons.clear, color: _graySoft),
                            onPressed: () {
                              _searchController.clear();
                              setState(() {
                                _searchQuery = '';
                              });
                            },
                          )
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 18,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: _bgColor,
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
              child: SizedBox(
                height: 48,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    String category = _categories[index];
                    bool isSelected = category == _selectedCategory;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        child: FilterChip(
                          label: Text(
                            category,
                            style: TextStyle(
                              color: isSelected ? Colors.white : _primaryBlue,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                              fontSize: 13,
                            ),
                          ),
                          selected: isSelected,
                          selectedColor: _primaryBlue,
                          backgroundColor: Colors.white,
                          checkmarkColor: Colors.white,
                          elevation: isSelected ? 2 : 0,
                          shadowColor: _primaryBlue.withValues(alpha: 0.2),
                          side: BorderSide(
                            color: isSelected ? _primaryBlue : _graySoft.withValues(alpha: 0.2),
                            width: 1,
                          ),
                          onSelected: (selected) {
                            setState(() {
                              _selectedCategory = category;
                            });
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 8)),
          SliverToBoxAdapter(
            child: Container(
              color: _bgColor,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _isLoading
                  ? Center(
                      child: Container(
                        margin: const EdgeInsets.all(60),
                        padding: const EdgeInsets.all(28),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: _primaryBlue.withValues(alpha: 0.1),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 40,
                              height: 40,
                              child: CircularProgressIndicator(
                                color: _primaryBlue,
                                strokeWidth: 3,
                              ),
                            ),
                            const SizedBox(height: 18),
                            Text(
                              'Miangavy mijanona...',
                              style: TextStyle(
                                color: _graySoft,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : _filteredPrieres.isEmpty
                      ? SizedBox(
                          height: 300,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.search_off,
                                  size: 64,
                                  color: _graySoft.withValues(alpha: 0.4),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Tsy hita intsony',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: _graySoft,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Column(
                          children: _filteredPrieres.map((priere) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: _PriereCard(
                                priere: priere,
                                icon: _getCategoryIcon(priere.categorie),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          PriereDetailScreen(priere: priere),
                                    ),
                                  );
                                },
                              ),
                            );
                          }).toList(),
                        ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
        ],
      ),
    );
  }
}

class _PriereCard extends StatelessWidget {
  final Priere priere;
  final IconData icon;
  final VoidCallback onTap;

  static const Color _primaryBlue = Color(0xFF2C4A6B);
  static const Color _gold = Color(0xFFD4AF37);
  static const Color _graySoft = Color(0xFF6B7280);

  const _PriereCard({
    required this.priere,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: _graySoft.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
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
                      priere.titre,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: const Color(0xFF1F2937),
                        letterSpacing: 0.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _gold.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            priere.categorie,
                            style: TextStyle(
                              fontSize: 11,
                              color: _primaryBlue,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                          color: _graySoft.withValues(alpha: 0.5),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}