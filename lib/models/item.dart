import 'package:cloud_firestore/cloud_firestore.dart';

List<Item> allItems = [
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Satin Maxi Green', brand: 'KENZ & KATE', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: '1.jpg', brand: 'ELIYA THE LABEL TAHNEE DRESS', colour: ['Red'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: '2.jpg', brand: 'ELIYA THE LABEL TAHNEE DRESS', colour: ['Blue'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Amalia Knit', brand: 'BEC + BRIDGE', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Anais Silk Cutout Midi', brand: 'ROCOCO SAND', colour: ['Green'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Anastasia Diamant Set', brand: 'MESHKI', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Annika Maxi', brand: 'BEC + BRIDGE', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Aphrodite Silk Gown', brand: 'CULT GAIA', colour: ['White'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Aria', brand: 'HOUSE OF CB', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Aribella Silk Dress In Villa Livia', brand: 'REFORMATION', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Ballerina Marie Gown', brand: 'SELKIE', colour: ['Green'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Belinda', brand: 'LEXI', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Bianca', brand: 'HOUSE OF CB', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Blue Lotus Satin', brand: 'SHEIKE', colour: ['Blue'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Breathless Frill Sleeves', brand: 'AJE', colour: ['Blue'], size: ['4','6'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Candice Mini', brand: 'NADINE MERABI', colour: ['Green'], size: ['4','6'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Carla', brand: 'ELIYA THE LABEL', colour: ['Purple'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Carmelita Knit Lace Up', brand: 'HOUSE OF CB', colour: ['Yellow'], size: ['6','8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Carmen Peony Print Midi', brand: 'HOUSE OF CB', colour: ['White'], size: ['6','8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Cartellina', brand: 'BARDOT', colour: ['White'], size: ['10'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Catarina', brand: 'RAT & BOA', colour: ['Blue'], size: ['10'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Chaya', brand: 'HOUSE OF CB', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Claire A Line Mini', brand: 'MESHKI', colour: ['Green'], size: ['4'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Cosmic Aquarius', brand: 'ZIMMERMANN', colour: ['Green'], size: ['4'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Delfina Pleated Cutout', brand: 'ALC', colour: ['Blue','Black'], size: ['4','6'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Eden Cutout', brand: 'MESHKI', colour: ['Blue'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Elinor', brand: 'ELIYA THE LABEL', colour: ['White'], size: ['6'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Emilia', brand: 'SUNDRESS', colour: ['Yellow'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Erika Cotton Gingham', brand: 'SUNDRESS', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Esme', brand: 'ELIYA THE LABEL', colour: ['Black'], size: ['6'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Farah Feather', brand: 'BRONX AND BANCO', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Faye Corset Midi', brand: 'HOUSE OF CB', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Felizia', brand: 'HOUSE OF CB', colour: ['Black'], size: ['6'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Fionnula', brand: 'HOUSE OF CB', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Flavia', brand: 'LEXI', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'For Lamour Day', brand: 'SELKIE', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'buy', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Francesca', brand: 'ELIYA THE LABEL', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'buy', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Genevieve', brand: 'HOUSE OF CB', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'buy', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Georgette Blue Maxi', brand: 'HOUSE OF CB', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'buy', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Gold Sequin Long Short Mini', brand: 'UNEARTHED', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'both', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Green Lurex Halter', brand: 'UNEARTHED', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'both', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Hayden Lace', brand: 'BARDOT', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'both', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'High Tide Applique Linen Creamy Poppy', brand: 'ZIMMERMANN', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'both', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'High Tide Linen And Silk', brand: 'ZIMMERMANN', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'High Tide Odessey Midi Shirt', brand: 'ZIMMERMANN', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'High Tide Tuxedo Mini Lilac', brand: 'ZIMMERMANN', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Imogen Dress In Periwinkle', brand: 'HOUSE OF CB', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Imory', brand: 'BARDOT', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Ira Sequin', brand: 'BARDOT', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Isadora', brand: 'LEXI', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Ivory Bebe Bloom', brand: 'SELKIE', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Jaime Broderoe Anglais', brand: 'HOUSE OF CB', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Janis', brand: 'HOUSE OF CB', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Joan Puff Sleeve Mini', brand: 'AJE', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Julia Tiered', brand: 'SHEIKE', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Kim Wrap', brand: 'UMA AND LEOPOLD', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Kiss On The Lips Day', brand: 'SELKIE', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Laetitia', brand: 'HOUSE OF CB', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Lauren', brand: 'HOUSE OF CB', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Lelya Turquoise', brand: 'MESHKI', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Lipari Spring 2008 Vintage Silk Organze Gown', brand: 'DIANE VON FURSTENBERG', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Lola Lemon', brand: 'NADINE MERABI', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Lova Corset Maxi', brand: 'HOUSE OF CB', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Lyla Silk Linen', brand: 'ALEMAIS', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Malia Nightshade Lace Maxi', brand: 'HOUSE OF CB', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Mariella Polka Dot', brand: 'RAT & BOA', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Mathilde Bubble Hem', brand: 'AJE', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Maya', brand: 'LEXI', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Metallic Gold Pleated Gown', brand: 'UNEARTHED', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Moondance', brand: 'BEC + BRIDGE', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Nami Knit', brand: 'CULT GAIA', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Nocha Diamante', brand: 'MESHKI', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Nycb Collection For', brand: 'REFORMATION X', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Olea', brand: 'BARDOT', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Onyx Top', brand: 'RAT & BOA', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Paradiso Cinched Mini', brand: 'AJE', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Pax Tricolor Long', brand: 'ROCOCO SAND', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Phedra Linen Tangerine', brand: 'HOUSE OF CB', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Pietra Corset', brand: 'HOUSE OF CB', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Rafaela Pure Silk And Lace', brand: 'HOUSE OF CB', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Ribera Maxi', brand: 'BAOBAB', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Riley Chiffon Maxi Cream', brand: 'LEXI', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Rose Gold Sequin Gown', brand: 'UNEARTHED', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Sabine', brand: 'HOUSE OF CB', colour: ['Blac'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Salome ', brand: 'HOUSE OF CB', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'San Marino Beaded Maxi', brand: 'OH POLLY', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Sarina', brand: 'HOUSE OF CB', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Scherri', brand: 'ELIYA THE LABEL', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Serafia', brand: 'RAT & BOA', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Sheena Maxi', brand: 'LEXI', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Socorro Glitter Mini', brand: 'HOUSE OF CB', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Talya', brand: 'HOUSE OF CB', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Thalia', brand: 'RATBOA', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Tidal Tucked Cutout Mini', brand: 'AJE', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Violette Bubble Hem Maxi', brand: 'AJE', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'Wyatt Polka Dot', brand: 'BARDOT', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'unknown', brand: 'HOUSE OF CB', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'unknown', brand: 'RAT & BOA', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'unknown', brand: 'ROCOCO SAND', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),
Item(id: '-', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'unknown', brand: 'UMA AND LEOPOLD', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: '', ),

];

class Item {
  
  Item({required this.id, 
          required this.type, 
          required this.bookingType, 
          required this.occasion,
          required this.dateAdded,
          required this.style, 
          required this.name, 
          required this.brand, 
          required this.colour, 
          required this.size, 
          required this.length,
          required this.print,
          required this.sleeve,
          required this.rentPrice, 
          required this.buyPrice, 
          required this.rrp,
          required this.description,
          required this.bust,
          required this.waist,
          required this.hips,
          required this.longDescription,
          required this.imageId,
        });

    String id;
    String type;
    String bookingType;
    List occasion;
    String dateAdded;
    String style;
    String name;
    String brand;
    List colour;
    List size;
    String length;
    String print;
    String sleeve;
    int rentPrice;
    int buyPrice;
    int rrp;
    String description;
    String bust;
    String waist;
    String hips;
    String longDescription;
    String imageId;
    


  // item to firestore (map, bust: '', waist: '', hips: '', imageId: '', )
  Map<String, dynamic> toFirestore() {
    return {
      'type': type,
      'bookingType': bookingType,
      'occasion': occasion,
      'dateAdded': dateAdded,
      'style': style,
      'name': name,
      'brand': brand,
      'colour': colour,
      'size': size,
      'length': length,
      'print': print,
      'sleeve': sleeve,
      'rentPrice': rentPrice,
      'buyPrice': buyPrice,
      'rrp': rrp,
      'description': description,
      'bust': bust,
      'waist': waist,
      'hips': hips,
      'longDescription': longDescription,
      'imageId': imageId,
    };
  }

  // character from firestore
  factory Item.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {

    // get data from snapshot
    final data = snapshot.data()!;

    // make character instance
    Item item = Item(
      id: snapshot.id,
      type: data['type'],
      bookingType: data['bookingType'],
      dateAdded: data['dateAdded'],
      occasion: data['occasion'],
      style: data['style'],
      name: data['name'],
      brand: data['brand'],
      colour: data['colour'],
      size: data['size'],
      length: data['length'],
      print: data['print'],
      sleeve: data['sleeve'],
      rentPrice: data['rentPrice'],
      buyPrice: data['buyPrice'],
      rrp: data['rrp'],
      description: data['description'],
      bust: data['bust'],
      waist: data['waist'],
      hips: data['hips'],
      longDescription: data['longDescription'],
      imageId: data['imageId'],
    );

    return item;
  } 
  
  
}
