const String mockRiderId = 'rid_1';

const Map<String, dynamic> mockRider = {
  'id': mockRiderId,
  'firstName': 'Emeka',
  'lastName': 'A.',
  'email': 'emeka@example.com',
  'phone': '+2348000000002',
  'avatar': 'E',
  'vehicle': {'type': 'BIKE', 'plateNumber': 'LGA-4821-BD', 'make': 'Kawasaki'},
  'rating': 4.9,
  'balance': 12450,
};

final List<Map<String, dynamic>> mockDeliveries = [
  {
    'id': 'del_1',
    'trackingId': 'MOVA-8392',
    'status': 'IN_TRANSIT',
    'userId': 'usr_1',
    'riderId': 'rid_1',
    'pickupAddress': '12 Admiralty Way, Lekki Phase 1, Lagos',
    'dropoffAddress': '3 Ozumba Mbadiwe, Victoria Island, Lagos',
    'estimatedPrice': 2500,
    'distanceKm': 5.2,
    'package': {'category': 'electronics', 'size': 'SMALL', 'description': 'Laptop charger'},
    'recipient': {'name': 'Jane Smith', 'phone': '+2348000000004'},
    'events': [
      {'status': 'CREATED', 'label': 'Order Placed', 'time': '10:02 AM', 'desc': 'Your delivery request was received', 'done': true, 'icon': '📋'},
      {'status': 'RIDER_ASSIGNED', 'label': 'Rider Assigned', 'time': '10:08 AM', 'desc': 'Emeka A. accepted your order', 'done': true, 'icon': '🏍️'},
      {'status': 'PACKAGE_RECEIVED', 'label': 'Picked Up', 'time': '10:25 AM', 'desc': 'Package collected from pickup location', 'done': true, 'icon': '📦'},
      {'status': 'IN_TRANSIT', 'label': 'In Transit', 'time': '10:32 AM', 'desc': 'Rider is heading to your destination', 'done': true, 'icon': '🚀'},
      {'status': 'RIDER_ARRIVED_DESTINATION', 'label': 'Arriving Soon', 'time': '~10:47 AM', 'desc': 'Estimated 15 minutes away', 'done': false, 'icon': '📍'},
      {'status': 'COMPLETED', 'label': 'Delivered', 'time': '--', 'desc': 'Package will be delivered to your address', 'done': false, 'icon': '✅'}
    ],
    'createdAt': DateTime.now().subtract(const Duration(hours: 1)).toIso8601String(),
  },
  {
    'id': 'del_4',
    'trackingId': 'MOVA-2281',
    'status': 'SEARCHING_RIDER',
    'userId': 'usr_2',
    'riderId': null,
    'pickupAddress': 'Ikoyi, Lagos',
    'dropoffAddress': 'Marina, Lagos',
    'estimatedPrice': 2100,
    'distanceKm': 6.5,
    'package': {'category': 'documents', 'size': 'SMALL', 'description': 'Office files'},
    'recipient': {'name': 'Mr. Johnson', 'phone': '+2348000000007'},
    'events': [
      {'status': 'CREATED', 'label': 'Order Placed', 'time': 'Just now', 'desc': 'Your delivery request was received', 'done': true, 'icon': '📋'},
      {'status': 'SEARCHING_RIDER', 'label': 'Searching for rider', 'time': '...', 'desc': 'Finding the nearest available rider', 'done': false, 'icon': '🔍'}
    ],
    'createdAt': DateTime.now().toIso8601String(),
  }
];

final List<Map<String, dynamic>> mockWalletTx = [
  {'id': 'tx_1', 'type': 'CREDIT', 'amount': 2500, 'desc': 'Delivery MOVA-8392', 'date': DateTime.now().subtract(const Duration(hours: 1)).toIso8601String()},
  {'id': 'tx_2', 'type': 'CREDIT', 'amount': 1500, 'desc': 'Delivery MOVA-3341', 'date': DateTime.now().subtract(const Duration(days: 1)).toIso8601String()},
];
