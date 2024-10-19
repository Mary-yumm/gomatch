import 'package:geolocator/geolocator.dart';
import 'package:gomatch/Assistants/requestAssistant.dart';
import 'package:gomatch/configMaps.dart';
import 'package:gomatch/models/address.dart';
import 'package:gomatch/providers/appData.dart';
import 'package:provider/provider.dart';

class AssistantMethods {
  static Future<String> searchCoordinateAddress(Position position, context) async {
    String placeAddress = "";
    String st1,st2,st3,st4,st5,st6,st7;
    String url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey";

    var response = await Requestassistant.getRequest(url);

    // Log the full response for debugging
    print("Geocoding API Response: $response");

    if (response != "Failed, No Response." && response != null) {
      if (response["results"] != null && response["results"].length > 0) {
        st1 = response["results"][0]["address_components"][0]["long_name"];
        st2 = response["results"][0]["address_components"][1]["long_name"];
        st3 = response["results"][0]["address_components"][2]["long_name"];
        st4 = response["results"][0]["address_components"][3]["long_name"];
        st5 = response["results"][0]["address_components"][4]["long_name"];
        st6 = response["results"][0]["address_components"][5]["long_name"];
        st7 = response["results"][0]["address_components"][6]["long_name"];
        placeAddress = "$st1, $st2, $st3, $st4,$st5,$st6,$st7";
        Address userPickupAddress = new Address(placeFormattedAddress: "",placeName: "",placeId: "",latitude: 0.0,longitude: 0.0);
        userPickupAddress.latitude = position.latitude;
        userPickupAddress.longitude = position.longitude;
        userPickupAddress.placeName = placeAddress;

        Provider.of<AppData>(context, listen: false).updatePickUpLocationAddress(userPickupAddress);
        
      } else {
        return "No address found.";
      }

    } else {
      return "Failed to retrieve address.";
    }

    return placeAddress;
  }
}

