class Neomutt < Formula
  desc "Teaching an Old Dog New Tricks"
  homepage "https://www.neomutt.org/"
  url "https://github.com/neomutt/neomutt.git", :tag => "neomutt-20180716", :revision => "6a147a62cf39c2a12cf2e96a8a62f378164548fa"
  head "https://github.com/neomutt/neomutt.git", :branch => "master"

  option "with-lmdb", "Build with lmdb support"
  option "with-lua", "Build with lua scripting support enabled"
  option "with-s-lang", "Build against slang instead of ncurses"
  option "with-fcntl", "Build with fcntl support (default)"
  option "with-flock", "Build with flock support"
  option "with-idn2", "Build with idn2 support"

  # Neomutt-specific patches
  option "with-notmuch-patch", "Apply notmuch patch"

  depends_on "gettext" => :build
  depends_on "docbook" => :build
  depends_on "docbook-xsl" => :build
  depends_on "libxslt" => :build unless OS.mac?
  depends_on "krb5" => :build unless OS.mac?

  depends_on "openssl"
  depends_on "tokyo-cabinet" => :recommended unless build.with?("lmdb")
  depends_on "lmdb" => :optional
  depends_on "gpgme" => :optional
  depends_on "libidn" => :optional
  depends_on "lua" => :optional
  depends_on "s-lang" => :optional
  # depends_on "fcntl" => :optional
  # depends_on "flock" => :optional
  depends_on "libidn2" => :optional
  depends_on "notmuch" if build.with? "notmuch-patch"

  def install
    # Find our docbook catalog
    ENV["XML_CATALOG_FILES"] = "#{etc}/xml/catalog"

    args = %W[
      --prefix=#{prefix}
      --with-ssl=#{Formula["openssl"].opt_prefix}
      --gss
      --disable-idn
    ]

    if build.with? "gpgme"
      args << "--enable-gpgme"
      args << "--with-gpgme=#{Formula["gpgme"].opt_prefix}"
    end

    # Neomutt-specific patches
    args << "--notmuch" if build.with? "notmuch-patch"

    args << "--with-lock=fcntl" if build.with? "fcntl"

    args << "--with-lock=flock" if build.with? "flock"

    args << "--idn2" if build.with? "libidn2"

    args << "--sasl" unless OS.linux?

    if build.with? "lmdb"
      args << "--lmdb"
    else
      args << "--tokyocabinet"
    end

    if build.with? "lua"
      args << "--lua"
      args << "--with-lua=#{Formula["lua"].prefix}"
    end

    if build.with? "s-lang"
      args << "--with-ui=slang"
    else
      args << "--with-ui=ncurses"
    end

    system "./configure", *args
    system "make"

    system "make", "install"
  end

  test do
    system bin/"neomutt", "-D"
  end
end
