;; Versa, India office holiday list
(setq holiday-other-holidays
      '(
        ;; January
        (holiday-fixed 1 1   "New Year's Day")
        (holiday-fixed 1 15  "Makar Sankranti")
        (holiday-fixed 1 26  "Republic Day")

        ;; February
        ;; March
        (holiday-fixed 3 7   "Mahashivaratri*")
        (holiday-fixed 3 25  "Good Friday")

        ;; April
        (holiday-fixed 4 8   "Chandramana Ugadi")
        (holiday-fixed 4 14  "Dr. Ambedkar's Birthday*")
        (holiday-fixed 4 19  "Mahavir Jayanti*")

        ;; May
        ;; June
        ;; July
        (holiday-fixed 7 6   "Ramazan")

        ;; August
        (holiday-fixed 8 15  "Independence Day")
        (holiday-fixed 8 25  "Janmasthami*")

        ;; September
        (holiday-fixed 9 5   "Ganesh Chaturthi")
        (holiday-fixed 9 12  "Bakri Id*")
        (holiday-fixed 9 13  "Onam*")

        ;; October
        (holiday-fixed 10 10 "Ayudha Pooja*")
        (holiday-fixed 10 11 "Vijayadasami")
        (holiday-fixed 10 12 "Muharram*")
        (holiday-fixed 10 30 "Diwali")
        (holiday-fixed 10 31 "Balipadyami*")

        ;; November
        (holiday-fixed 11 1  "Rajyotsava Day")

        ;; December
        (holiday-fixed 12 12 "Id-e-Milad*")
        (holiday-fixed 12 25 "Christmas")
        ))

(provide 'india-holidays-2016)
