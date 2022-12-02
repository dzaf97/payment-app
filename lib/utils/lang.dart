//! Adding translation function here
// import 'package:flutterbase/states/app_state.dart';

// enum AvailableLang { en, ms_MY }

// Map<AvailableLang, Map<String, String>> _terms = {
//   AvailableLang.ms_MY: {
//     "What's new in PahangGo?": 'Apa yang terbaharu di \nPahang Go?',
//     'New feature': 'Berwajah Baru',
//     '**Please make sure the details is correct before proceed payment.':
//         '**Sila pastikan butiran adalah betul sebelum membuat pembayaran.',
//     'FAQ': 'FAQ'
//   },
// };

// String t(String term) {
//   if (state.value.lang == AvailableLang.en) return term;

//   if (!_terms.containsKey(state.value.lang)) {
//     print('Lang ' + state.value.lang.toString() + ' not available.');
//     return term;
//   }
//   if (!_terms[state.value.lang]!.containsKey(term)) {
//     print('    \'' + term + '\': \'' + term + '\',');
//     return term;
//   }
//   return _terms[state.value.lang]![term]!;
// }
