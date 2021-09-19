import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:simdatixtest/model/ticketModel.dart';
import 'package:simdatixtest/provider/apiClient.dart';
import 'package:simdatixtest/provider/userProvider.dart';
import 'package:simdatixtest/style/renkler.dart';
import 'package:simdatixtest/style/svgler.dart';
import 'package:simdatixtest/style/taslak.dart';

class Tickets extends StatelessWidget {
  Renkler renkler = Renkler();
  Svgler svgler = Svgler();

  @override
  Widget build(BuildContext context) {
    var apiClient = Provider.of<ApiClient>(context);
    Provider.of<ApiClient>(context, listen: false).getData();
    TicketModel data = apiClient.model;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(size,context),
      body: data.date == null
          ? Taslak().loading(size)
          : ListView(
              padding: EdgeInsets.symmetric(
                  vertical: size.width * 0.05, horizontal: size.width * 0.08),
              children: [
                Container(
                  height: size.height * 0.6,
                  width: size.width * 0.8,
                  decoration: _decoration(size),
                  padding:
                      EdgeInsets.symmetric(horizontal: size.height * 0.024),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          _title(size, "Departure time", "Arrival time"),
                          _time(size, data.departureTime.toString(),
                              data.arrivalTime.toString()),
                        ],
                      ),
                      _rota(
                          size,
                          data.departureCity.toString(),
                          data.arrivalCity.toString(),
                          data.departureBusStop.toString(),
                          data.arrivalBusStop.toString()),
                      Column(
                        children: [
                          _title(size, "Passenger", "Seat"),
                          _name(size, data.passengerName.toString(),
                              data.seatNu.toString()),
                        ],
                      ),
                      Column(
                        children: [
                          _title(size, "Tour Number", "Date"),
                          _tourDeail(size, data.tourNumber.toString(),
                              data.date.toString()),
                        ],
                      ),
                      _ticketQrDetail(
                          size,
                          "Ticket Number",
                          "Booking Number",
                          data.ticketNumber.toString(),
                          data.bookingNumber.toString(),
                          data.qrCode.toString()),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  _appBar(Size size,BuildContext context) {
    return AppBar(
      toolbarHeight: size.height * 0.13,
      backgroundColor: renkler.turuncu,
      centerTitle: true,
      title: Text(
        "Tickets",
        style: TextStyle(
            color: Colors.white,
            fontSize: size.height * 0.024,
            fontWeight: FontWeight.w600),
      ),
      leading: Padding(
          padding: EdgeInsets.all(size.height * 0.03),
          child: SvgPicture.string(svgler.bus)),
      actions: [
        TextButton(
            onPressed: () {
              Provider.of<UserControl>(context, listen: false).change(0);
              Provider.of<UserControl>(context, listen: false)
                  .removePreferences();
            },
            style: ButtonStyle(overlayColor: MaterialStateColor.resolveWith((states) => renkler.kirmizi.withOpacity(0.2)),),
            child: Center(
                child: Text(
              "Sign Out",
              style: TextStyle(
                  color: renkler.beyaz,
                  fontWeight: FontWeight.w400,
                  fontSize: size.height * 0.015),
            )))
      ],
    );
  }

  _decoration(Size size) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(size.height * 0.024),
        gradient: LinearGradient(
          colors: [
            renkler.linear1,
            renkler.linear2,
          ],
          end: Alignment.bottomCenter,
          begin: Alignment.topCenter,
          stops: [0.0, 0.6],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(1.0, 1.0),
            spreadRadius: 4,
          )
        ]);
  }

  _title(Size size, String title, String title2) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
                color: renkler.titleColor, fontSize: size.height * 0.024),
            textAlign: TextAlign.left,
          ),
        ),
        Expanded(
          child: Text(
            title2,
            style: TextStyle(
                color: renkler.titleColor, fontSize: size.height * 0.024),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  _time(Size size, String time, String time2) {
    return Row(
      children: [
        Expanded(
          child: Text(
            time,
            style: TextStyle(
                color: renkler.siyah,
                fontSize: size.height * 0.028,
                fontWeight: FontWeight.w500),
            textAlign: TextAlign.left,
          ),
        ),
        Expanded(
          child: Text(
            time2,
            style: TextStyle(
                color: renkler.siyah,
                fontSize: size.height * 0.028,
                fontWeight: FontWeight.w500),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  _rota(Size size, String rota, String rota2, String city, String city2) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                rota,
                style: TextStyle(
                    color: renkler.turuncu,
                    fontSize: size.height * 0.040,
                    fontWeight: FontWeight.w700),
                textAlign: TextAlign.left,
              ),
            ),
            SvgPicture.string(svgler.ok),
            Expanded(
              child: Text(
                rota2,
                style: TextStyle(
                    color: renkler.turuncu,
                    fontSize: size.height * 0.040,
                    fontWeight: FontWeight.w700),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                city,
                style: TextStyle(
                    color: renkler.unSelected,
                    fontSize: size.height * 0.022,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.left,
              ),
            ),
            Expanded(
              child: Text(
                city2,
                style: TextStyle(
                    color: renkler.unSelected,
                    fontSize: size.height * 0.022,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ],
    );
  }

  _name(Size size, String name, String seat) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: Text(
            name,
            style: TextStyle(
                color: renkler.siyah,
                fontSize: size.height * 0.028,
                fontWeight: FontWeight.w500),
            textAlign: TextAlign.left,
          ),
        ),
        Expanded(
          child: Container(
              decoration: BoxDecoration(
                color: renkler.turuncu,
                borderRadius: BorderRadius.circular(size.height * 0.01),
              ),
              child: Center(
                  child: Text(
                seat,
                style: TextStyle(
                    color: renkler.beyaz,
                    fontSize: size.height * 0.024,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.right,
              ))),
        ),
      ],
    );
  }

  _tourDeail(Size size, String number, String date) {
    return Row(
      children: [
        Expanded(
          child: Text(
            number,
            style: TextStyle(
                color: renkler.siyah,
                fontSize: size.height * 0.028,
                fontWeight: FontWeight.w500),
            textAlign: TextAlign.left,
          ),
        ),
        Expanded(
          child: Text(
            date,
            style: TextStyle(
                color: renkler.siyah,
                fontSize: size.height * 0.028,
                fontWeight: FontWeight.w500),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  _ticketQrDetail(Size size, String title, String title2, String number,
      String number2, String qrcode) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: renkler.titleColor,
                        fontSize: size.height * 0.024),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    number,
                    style: TextStyle(
                        color: renkler.siyah,
                        fontSize: size.height * 0.028,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.left,
                  )
                ],
              ),
              SizedBox(
                height: size.height * 0.024,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title2,
                    style: TextStyle(
                        color: renkler.titleColor,
                        fontSize: size.height * 0.024),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    number2,
                    style: TextStyle(
                        color: renkler.siyah,
                        fontSize: size.height * 0.028,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.left,
                  )
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: QrImage(
            data: qrcode,
          ),
        ),
      ],
    );
  }
}
